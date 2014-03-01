76859# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-simplegit'
  spec.version       = '0.0.4'
  spec.authors       = ['Ross Riley']
  spec.email         = ['riley.ross@gmail.com']
  spec.description   = %q{A simple Git Deploy Command for Capistrano 3.x}
  spec.summary       = %q{A simple Git Deploy Command for Capistrano 3.x}
  spec.homepage      = 'https://github.com/rossriley/capistrano-simplegit'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'capistrano', '>= 3.1.0'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
