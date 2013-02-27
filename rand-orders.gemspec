# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rand/version'

Gem::Specification.new do |gem|
  gem.name          = "rand"
  gem.version       = Rand::Orders::VERSION
  gem.authors       = ["santaux"]
  gem.email         = ["santaux@gmail.com"]
  gem.description   = %q{Simple gem which provides random ordering for mysql, postgresql and sqlite}
  gem.summary       = %q{Simple gem which provides random ordering for mysql, postgresql and sqlite}
  gem.homepage      = "http://github.com/santaux/rand"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "sqlite3"
  gem.add_development_dependency "pg"
  gem.add_development_dependency "mysql2"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "redcarpet", "~> 1.17"
  gem.add_development_dependency "yard", "~> 0.7.5"
  gem.add_development_dependency "rspec-core", "~> 2.0"
  gem.add_development_dependency "rspec-expectations", "~> 2.0"
  gem.add_development_dependency "rr", "~> 1.0"
  gem.add_development_dependency "machinist", ">= 2.0.0.beta2"
  gem.add_development_dependency "faker"
end
