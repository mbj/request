# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name        = 'request'
  gem.version     = '0.0.4'
  gem.authors     = [ 'Markus Schirp' ]
  gem.email       = [ 'mbj@schirp-dso.com' ]
  gem.description = 'HTTP request porofication'
  gem.summary     = gem.description
  gem.homepage    = 'https://github.com/mbj/response'

  gem.require_paths    = [ 'lib' ]
  gem.files            = `git ls-files`.split("\n")
  gem.test_files       = `git ls-files -- {spec}/*`.split("\n")
  gem.extra_rdoc_files = %w[LICENSE README.md TODO]

  gem.add_dependency('backports',     [ '~> 3.0', '>= 3.0.3' ])
  gem.add_dependency('concord',       '~> 0.1.0')
  gem.add_dependency('ice_nine',      '~> 0.8.0')
  gem.add_dependency('adamantium',    '~> 0.0.8')
  gem.add_dependency('equalizer',     '~> 0.0.5')
  gem.add_dependency('abstract_type', '~> 0.0.5')
end
