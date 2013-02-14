module ASassIn

  class Reports

    def feed(report_data, threshold, report_type)
      @infringing_files = []
      @report_data = report_data
      @threshold = threshold
      @infringers = get_infringers
      @report_type = report_type
      report
    end

    def report
      puts intro
      puts details
      if @report_type > 0 then puts file_list end
    end


    def intro
    <<-intro

      It's #{'A'.yellow}.#{'Sass'.green}.#{'in'.yellow}!
      I scanned #{@report_data.length.to_s.black_on_white} sass files.

      Here's what I found:

    intro
    end


    def details
      <<-details
        * Total files: #{@report_data.length}
        * Tab Threshold: #{@threshold}
        * Infringers: #{@infringers} (#{colour_threshold( get_infringing_percentage.round(2), [25,10,0] )}%)
      details
    end


    def file_list
      report = ''
      @infringing_files.each do |inf|
        line_list = []
        inf[:infringing_lines].each_slice(20) { |a| line_list.push a.join(',') }
        report += "\t#{'-' * 80}\n"
        report += <<-file_report
        File name: #{inf[:name]}
        Location: #{inf[:full_path]}
        Infringing lines: #{colour_threshold( inf[:infringing_lines].length, [20,10,0] )}
        Line list:
        #{line_list.join("\n\t") }
        file_report
      end
      report
    end

    private

    def get_infringers
      infringers = 0
      infringing_files = []
      @report_data.each { |r|
        if r[:infringing_lines].length > 0
          infringers +=1
          infringing_files.push(r)
        end
      }
      @infringing_files = infringing_files
      infringers
    end


    def get_infringing_percentage
      (100.0/@report_data.length) * @infringers || 0
    end


    def colour_threshold number, threshold = [25,10,0]
      colours = [ 'red','yellow','green' ]
      top = threshold.find_all { |val| number.to_i > val  }.max || 0
      number.to_s.send( colours[  threshold.index top  ] )
    end

  end

end
