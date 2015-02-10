# coding: utf-8
version = File.read(File.expand_path('../VERSION', __FILE__)).strip

Gem::Specification.new do |s|
  s.name         = 'end_view'
  s.version      = version
  s.author       = 'Max White'
  s.email        = 'mushishi78@gmail.com'
  s.homepage     = 'https://github.com/mushishi78/end_view'
  s.summary      = 'View model and template in same file.'
  s.license      = 'MIT'
  s.files        = Dir['LICENSE.txt', 'README.md', 'lib/**/*']
  s.require_path = 'lib'
  s.add_runtime_dependency 'tilt'
  s.add_runtime_dependency 'haml'
  s.add_runtime_dependency 'attire', '~> 0.1', '>= 0.1.2'
  s.add_runtime_dependency 'inflecto', '~> 0.0', '>= 0.0.2'
  s.add_development_dependency 'rspec', '~> 3.1', '>= 3.1.0'
  s.add_development_dependency 'rspec-html-matchers', '~> 0.6', '>= 0.6.1'
end
