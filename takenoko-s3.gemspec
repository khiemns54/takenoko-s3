# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'takenoko/s3/version'

Gem::Specification.new do |spec|
  spec.name          = "takenoko-s3"
  spec.version       = Takenoko::S3::VERSION
  spec.authors       = ["KhiemNS"]
  spec.email         = ["khiem-nguyen@kayac.com"]

  spec.summary       = %q{S3 Uploader plugin for takenoko}
  spec.description   = %q{S3 Uploader plugin for takenoko}
  spec.homepage      = "https://github.com/khiemns54/takenoko-s3/tree/release/0.0.999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_dependency "takenoko", "~> 0.2.6"
  spec.add_dependency "fog-aws"

end
