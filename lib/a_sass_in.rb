require "a_sass_in/version"
require "a_sass_in/cli"
require "a_sass_in/scanner"
require "a_sass_in/reporter"


module ASassIn

  def run(args)
    ASassIn::FileManager.new(args).scan
  end

  module_function :run

end