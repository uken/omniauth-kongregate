# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-kongregate/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Chester / Uken Games"]
  gem.email         = ["chester@uken.com"]
  gem.description   = %q{OmniAuth Strategy for Kongregate}
  gem.summary       = %q{Allows applications to get the kongregate id and username}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "omniauth-kongregate"
  gem.require_paths = ["lib"]
  gem.version       = Omniauth::Kongregate::VERSION

  gem.add_dependency "omniauth"
  gem.add_development_dependency "webmock"
  gem.add_development_dependency "rspec-rails"
  gem.add_development_dependency "capybara"
  gem.add_development_dependency "growl"
  gem.add_development_dependency "guard"
  gem.add_development_dependency "guard-rspec"

end
