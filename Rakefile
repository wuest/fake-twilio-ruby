require 'rake/testtask'
require 'rdoc/task'

task default: :test

Rake::TestTask.new(:test) do |t|
	t.libs.unshift File.expand_path('../test', __FILE__)
  t.test_files = Dir.glob('test/**/test_*.rb')
	t.ruby_opts << '-I./lib'
end
