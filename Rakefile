require "rubygems"
require "rake"
require "rspec"
require "rspec/core/rake_task"

$:.unshift File.expand_path("../lib", __FILE__)
require "sinatra/api_docs"

task :default => :spec

desc "Run all specs"
Rspec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
end

desc "Generate RCov code coverage report"
task :rcov => "rcov:build" do
  %x{ open coverage/index.html }
end

Rspec::Core::RakeTask.new("rcov:build") do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.rcov = true
  t.rcov_opts = [ "--exclude", Gem.default_dir, "--exclude", "spec" ]
end

######################################################

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name    = "sinatra-api-docs"
    s.version = Sinatra::APIDocs::VERSION

    s.summary     = "Create documentation for an API built in Sinatra."
    s.description = s.summary
    s.author      = "David Dollar"
    s.email       = "ddollar@gmail.com"
    s.homepage    = "http://daviddollar.org/"

    s.platform = Gem::Platform::RUBY
    s.has_rdoc = false

    s.files = %w(Rakefile README.markdown) + Dir["{lib,spec}/**/*"]
    s.require_path = "lib"

    s.add_development_dependency 'rake',    '~> 0.8.7'
    s.add_development_dependency 'rspec',   '~> 2.0.0.beta.5'

    s.add_dependency 'haml',      '~> 3.0.12'
    s.add_dependency 'json_pure', '~> 1.4.3'
    s.add_dependency 'sinatra',   '~> 1.0'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end
