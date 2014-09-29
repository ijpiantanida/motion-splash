# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "motion-splash"
  spec.version       = "1.0"
  spec.authors       = ["Ignacio Piantanida"]
  spec.email         = ["ijpiantanida@gmail.com"]
  spec.description   = "Create all your splash images from any UIViewController using whatever method you like to style it.\nWith Xcode 6 and iOS 8 came the ability to create your launch images from a XIB or storyboard file. This is a huge gain over manually creating every image in all the available resolutions.\nBut as a RubyMotion developer, I try to stay away as much as possible from the Xcode environment... I present you Motion-Splash"
  spec.summary       = "Create all your splash images from any UIViewController using whatever method you like to style it"
  spec.homepage      = "https://github.com/ijpiantanida/motion-splash"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
