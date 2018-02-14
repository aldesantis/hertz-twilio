# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'hertz/courier/twilio/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'hertz-twilio'
  s.version     = Hertz::Courier::Twilio::VERSION
  s.authors     = ['Alessandro Desantis']
  s.email       = ['desa.alessandro@gmail.com']
  s.homepage    = 'https://github.com/alessandro1997/hertz-twilio'
  s.summary     = 'A Twilio courier for Hertz.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'hertz', '~> 1.0'
  s.add_dependency 'rails', '>= 4.0.0', '< 6'
  s.add_dependency 'twilio-ruby', '~> 5.6'

  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_bot_rails'
  s.add_development_dependency 'faker'
  s.add_development_dependency 'fuubar'
  s.add_development_dependency 'pg', '~> 0.21'
  s.add_development_dependency 'rspec-activejob'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rubocop-rspec'
end
