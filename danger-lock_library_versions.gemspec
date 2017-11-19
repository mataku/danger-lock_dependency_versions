# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lock_library_versions/gem_version.rb'

Gem::Specification.new do |spec|
  spec.name          = 'danger-lock_library_versions'
  spec.version       = LockLibraryVersions::VERSION
  spec.authors       = ['mataku']
  spec.email         = ['nagomimatcha@gmail.com']
  spec.description   = %q{A Danger plugin to check whether version lockfile is committed or not}
  spec.summary       = %q{A Danger plugin to check whether version lockfile is committed or not}
  spec.homepage      = 'https://github.com/mataku/danger-lock_library_versions'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'danger-plugin-api', '~> 1.0'

  # General ruby development
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 10.0'

  # Testing support
  spec.add_development_dependency 'rspec', '~> 3.4'

  spec.add_development_dependency 'pry'
end
