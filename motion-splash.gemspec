# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "motion-splash"
  spec.version       = "1.0"
  spec.authors       = ["Ignacio Piantanida"]
  spec.email         = ["ijpiantanida@gmail.com"]
  spec.description   = "Create splash screens with RubyMotion"
  spec.summary       = "Bring RSpec 3.0 expect syntax to MacBacon"
  spec.homepage      = "https://github.com/ijpiantanida/motion-splash"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
