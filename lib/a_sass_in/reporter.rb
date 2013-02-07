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

      title = 'A'.yellow + '.' + 'Sass'.green + '.' + 'in'.yellow

    <<-intro

      It's #{title}!
      Through witchcraft, I scanned #{@report_data.length.to_s.black_on_white} sass files.

      Here's the low-down:

    intro


    end


    def details
      get_infringing_percentage
      <<-details
        * Total files: #{@report_data.length}
        * Tab Threshold: #{@threshold}
        * Infringers: #{@infringers} (#{get_infringing_percentage})

      details


    end


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
      percentage = (100.0/@report_data.length) * @infringers

      if percentage.nan?
        percentage = 0
      end

      case
        when percentage > 25
          (("%.2f" % percentage) + '%').red
        when percentage > 10
          (("%.2f" % percentage) + '%').yellow
        else 
          (("%.2f" % percentage) + '%').green
        end
    end


    def file_list

      report = ''

      @infringing_files.each { |inf|

        line_list = inf[:infringing_lines].join(',')
        report += <<-file_report

        --------------------------------------------------------------------------
        
        File name: #{inf[:name]}
        Location: #{inf[:full_path]}
        Infringing lines: #{inf[:infringing_lines].length.to_s.red}
        Line list: #{line_list}

        file_report

      }

      report

    end



  end

end
