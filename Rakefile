require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require File.join(File.dirname(__FILE__), 'lib', 'vkontakte', 'version')

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the vkontakte_oauth plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the vkontakte_oauth plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'VkontakteOauth'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "vkontakte_oauth"
    gemspec.version = Vkontakte::Version.dup
    gemspec.summary = "Ruby wrapper for Vkontakte Open API"
    gemspec.description = "Open API - система для разработчиков сторонних сайтов, которая предоставляет возможность легко авторизовывать пользователей ВКонтакте на Вашем сайте"
    gemspec.email = "galeta.igor@gmail.com"
    gemspec.homepage = "http://vkontakte.ru/pages.php?o=-1&p=Open+API"
    gemspec.authors = ["Igor Galeta", "Pavlo Galeta"]
    gemspec.files = FileList["[A-Z]*", "lib/**/*"]
    gemspec.rubyforge_project = "vkontakte_oauth"
  end
  
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end
