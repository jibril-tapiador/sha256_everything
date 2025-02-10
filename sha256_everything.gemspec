# frozen_string_literal: true

require_relative 'lib/sha256_everything/version'

Gem::Specification.new do |spec|
  spec.name          = 'sha256_everything'
  spec.version       = '0.1.0'
  spec.authors       = ['Jibril Tapiador']
  spec.email         = ['tapiador@jib.is']

  spec.summary       = 'Hashes every file in a directory using SHA256'
  spec.description   = 'A gem that iterates over each file in a folder, computes its SHA256 hash, and writes a prettified file hierarchy to a text file.'
  spec.homepage      = 'https://github.com/jibril-tapiador/sha256_everything'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*', 'bin/*', 'README.md', 'LICENSE', '*.gemspec']
  spec.executables   = ['sha256_everything']
  spec.require_paths = ['lib']

  spec.add_dependency 'ruby-progressbar', '~> 1.10'
end
