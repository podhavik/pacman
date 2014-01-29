# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pacman/version'

Gem::Specification.new do |spec|
  spec.name          = "rub-pacman"
  spec.version       = Pacman::VERSION
  spec.authors       = ["Viktor Podhajecky"]
  spec.email         = ["podhavik@gmail.com"]
  spec.summary       = %q{My variation on game pacman.}
  spec.description   = %q{Game based on pacman using Gosu. Ghost behavior is similar as in original game.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.add_dependency "gosu"
  spec.add_dependency "trollop"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
