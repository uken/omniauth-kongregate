# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-kongregate/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Chester (chesterbr) / Uken Games", "Pedro Mariano (pmariano)"]
  gem.email         = ["chester@uken.com", "pmariano@"]
  gem.description   = %q{OmniAuth Strategy for Kongregate}
  gem.summary       = %q{Allows applications to get the kongregate id and username}
  gem.homepage      = "http://github.com/uken/omniauth-kongregate"

  gem.files         = Dir["{lib}/**/*"] + ["Rakefile", "README.md"]
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "omniauth-kongregate"
  gem.require_paths = ["lib"]
  gem.version       = Omniauth::Kongregate::VERSION

  gem.add_dependency "omniauth", "~> 1.1.1"
  gem.add_development_dependency "bundler","~> 1.2.3"
  gem.add_development_dependency "webmock", "~> 1.9.0"
  gem.add_development_dependency "rspec-rails", "~> 2.0"
  gem.add_development_dependency "capybara"
  gem.add_development_dependency "growl"
  gem.add_development_dependency "guard"
  gem.add_development_dependency "guard-rspec"

end
