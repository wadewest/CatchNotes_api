require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "CatchNotes_api"
    gem.summary = %Q{An ActiveResource like interface to catch.com}
    gem.description = %Q{An ActiveResource like interface to catch.com}
    gem.email = "wwest81@gmail.com"
    gem.homepage = "http://github.com/wadewest/CatchNotes_api"
    gem.authors = ["Wade West"]
    
    gem.add_dependency 'httparty', '>=0.6.1'
    
    gem.add_development_dependency 'json', '>=1.4.6'
    gem.add_development_dependency "thoughtbot-shoulda", ">= 0"
    gem.add_development_dependency "sinatra", ">= 1.1.0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "CatchNotes_api #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
