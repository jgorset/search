# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'search/version'

Gem::Specification.new do |spec|
  spec.name          = 'search'
  spec.version       = Search::VERSION
  spec.authors       = ['Johannes Gorset']
  spec.email         = ['jgorset@gmail.com']

  spec.summary       = 'File search'
  spec.description   = 'File search'
  spec.homepage      = 'https://github.com/jgorset/search'
  spec.license       = 'MIT'

  spec.files         = Dir[
    '{lib,test,bin,doc,config}/**/*', 'LICENSE.txt', 'README*'
  ]

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'slop', '~> 4.4'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.5.0'
end
