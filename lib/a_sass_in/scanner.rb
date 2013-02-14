module ASassIn

  class FileManager

    def initialize(args)
      @reporter = ASassIn::Reports.new()
      @tab_type = nil
      @report_data = []
      @threshold = args[:threshold]
      @dir = args[:dir]
      @report_type = args[:report_type]
    end

    def scan
      @file_list = Dir.glob(@dir + '/**/*.s{a,c}ss')
      scan_all_files
    end


    def detect_tab_type(string)
      if string.match(/^[\t]+/)
        @tab_type = { type: 'tab', number: 1 }
      else
        @tab_type = { type: 'space', number: string.match(/^[ ]+/).to_s.length }
      end
    end

    def scan_all_files

      @file_list.each { |file|

        file_data = {
          name: file.split('/').last,
          full_path: file,
          line_data: {},
          infringing_lines: [],
        }

        File.open(file, 'r') do |f|

          f.each_line.with_index do |line,i|

            line_number = i + 1
            nesting = get_nesting(line)

            if begins_with_whitespace(nesting)

              if @tab_type.nil? then detect_tab_type(line) end

              tabs = count_nesting(nesting)
              file_data[:line_data][line_number] = tabs

              if infringes(tabs, @threshold) then file_data[:infringing_lines].push(line_number) end

            else
              file_data[:line_data][line_number] = 0
            end

          end
        end

        @report_data.push(file_data)

      }

      @reporter.feed(@report_data, @threshold, @report_type)

    end

    def get_nesting(string)
      string.encode('UTF-8', 'UTF-8', :invalid => :replace).match(/^[ \t]+/)
    end


    def begins_with_whitespace(whitespace)
      !whitespace.nil?
    end


    def count_nesting(match)
      if !match.nil?
        match.to_s.split('').length / @tab_type[:number]
      end
    end

    def infringes(tabs, threshold)
      tabs > threshold
    end

  end

end
