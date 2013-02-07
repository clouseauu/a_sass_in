require 'optparse'
require 'colored'
require 'pp'

module ASassIn

  class CLI

    DEFAULTS = {
      dir: './',
      report_type: 1,
      threshold: 4
    }

    def initialize(args)

      opts = parse(args)

      if opts
        ASassIn.run( opts )
      end
    end



    def parse(args)
      opts = OptionParser.new do |opts|

        opts.banner = "F*ck yeah A.Sass.In! Usage: a_sass_in [options]"
        opts.separator ""
        opts.separator "Specific options:"

        opts.on("-d", "--dir [directory]", String, "Directory to scan. Default: './'") do |d|
          options[:dir] = d
        end

        opts.on("-r", "--report [integer]", OptionParser::DecimalInteger, "Report type: 0: quick, 1: detailed, 2: full dump. Default: 1") do |r|
          options[:report_type] = r
        end

        opts.on("-t", "--threshold [integer]", OptionParser::DecimalInteger, "Indentation threshold for alerts. Default: 4") do |t|
          options[:threshold] = t
        end

        opts.on("-h", "--help", "Show this message. But then again you knew that already") do
          puts opts
          exit
        end

        opts.separator ""

      end

      opts.parse!(args)
      DEFAULTS.merge(options)

    end


    def options
      @options ||= {}
    end




  end

end