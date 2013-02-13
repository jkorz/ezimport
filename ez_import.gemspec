# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ez_import/version'

Gem::Specification.new do |gem|
  gem.name          = "ez_import"
  gem.version       = EzImport::VERSION
  gem.authors       = ["Joe Korzeniewski"]
  gem.email         = ["trogdor33@gmail.com"]
  gem.description   = %q{Ezimport reads and writes XML representations of data stored in rails models while preserving IDs.}
  gem.summary       = %q{Easily import and export static data from rails}
  gem.homepage      = "https://github.com/jkorz/ezimport"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "hpricot"
end
