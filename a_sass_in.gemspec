# -*- encoding: utf-8 -*-
require File.expand_path('../lib/a_sass_in/version', __FILE__)

Gem::Specification.new do |gem|

  gem.authors       = ["Daniel Angel Bradford"]
  gem.email         = ["locusdelicti -at- gmail -dot- com"]
  gem.description   = %q{Identify and report on sass excessive nesting}
  gem.summary       = %q{sass excessive nesting}
  gem.homepage      = "http://sarasa.sas"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "a_sass_in"
  gem.require_paths = ["lib"]
  gem.version       = ASassIn::VERSION

  gem.add_dependency 'colored'

  gem.add_development_dependency "rspec", "~> 2.6"
  gem.add_development_dependency "awesome_print"
  gem.add_development_dependency "pry"

end
