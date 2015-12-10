$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'fake_twilio/version'

Gem::Specification.new do |s|
  s.name = 'fake-twilio'
  s.version = FakeTwilio::VERSION

  s.description = 'Fake Twilio service to aid in local development'
  s.summary     = 'Fake Twilio service to aid in local development'
  s.authors     = ['Instructure, Inc.', 'Tina Wuest']
  s.email       = 'cwuest@instructure.com'
  s.homepage    = 'https://github.com/wuest/fake-twilio-ruby'

  s.required_ruby_version = '>= 2.1.1'

  s.files = `git ls-files lib`.split("\n")
  s.files += `git ls-files bin`.split("\n")

  s.executables = ['fake-twilio-server']

  s.add_runtime_dependency 'sinatra', '~> 1.4'
  s.add_runtime_dependency 'thin', '~> 1.6'

  s.license = 'MIT'
end
