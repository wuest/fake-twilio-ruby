require 'rake/testtask'
require 'rdoc/task'

task default: :test

Rake::TestTask.new(:test) do |t|
	t.libs.unshift File.expand_path('../test', __FILE__)
  t.test_files = Dir.glob('test/**/test_*.rb')
	t.ruby_opts << '-I./lib'

  if ENV['SERVER_TESTS']
    require 'open3'
    vals = Open3.popen3('ruby -I./lib bin/fake-twilio-server')
    t.test_files = Dir.glob('test/**/{test,client_test}_*.rb')
  end
end
