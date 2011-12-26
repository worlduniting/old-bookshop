require 'bundler'
require 'rake/clean'
require 'rubygems'
require 'rdoc/task'
require 'cucumber'
require 'cucumber/rake/task'

Bundler::GemHelper.install_tasks

Rake::RDocTask.new do |rd|
  rd.main = "README.rdoc"
  rd.rdoc_files.include("README.rdoc","lib/**/*.rb","bin/**/*")
  rd.title = 'BookShop'
end

spec = eval(File.read('bookshop.gemspec'))

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/test*.rb']
end

CUKE_RESULTS = 'results.html'
CLEAN << CUKE_RESULTS
CLOBBER << 'tmp'
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format html -o #{CUKE_RESULTS} --format progress -x"
  t.fork = false
end

task :default => :test
