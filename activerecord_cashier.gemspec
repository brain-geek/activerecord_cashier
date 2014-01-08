# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activerecord_cashier/version'

Gem::Specification.new do |spec|
  spec.name          = "activerecord_cashier"
  spec.version       = ActiverecordCashier::VERSION
  spec.authors       = ["Alex Rozumey"]
  spec.email         = ["brain-geek@yandex.ua"]
  spec.description   = %q{This gem extends cashier with possibility to add AR objects and classes as keys and automaticaly hook with AR to clean up this keys on object change/deletion}
  spec.summary       = %q{This gem extends cashier with AR integration}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "cashier", "~> 0.4.1"
  spec.add_dependency "activesupport", ">= 3.2.0"
  spec.add_dependency "activerecord", ">= 3.2.0"
  spec.add_dependency 'railties', '>= 3.2.0'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'combustion', '~> 0.5.1'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-nav"
  spec.add_development_dependency "rails", ">= 3.2.0"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency 'dalli'
  spec.add_development_dependency 'redis', '~> 2.2.0'
end
