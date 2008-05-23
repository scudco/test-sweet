require 'rubygems'
gem 'ci_reporter'
require 'ci/reporter/rake/rspec'
require 'ci/reporter/rake/test_unit'
require 'rake/testtask'
require 'spec/rake/spectask'
require 'fileutils'
require 'test_sweet/tag_filter'

desc 'Run unit tests'
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/test*.rb']
  t.verbose = true
end

namespace :test do
  desc 'Run application tests'
  Rake::TestTask.new(:application) do |t|
    app = ENV['app']
    tags = ENV['tag']
  
    file_pattern = "application_tests/**/#{app+'/**/' if app}test*.rb"
  
    if tags
      tags = tags.split(',')
      t.test_files = TestSweet::TagFilter.filter(file_pattern,tags)
    else
      t.test_files = FileList[file_pattern]
    end
  
    t.verbose = true
  end
end

desc 'Run lib specs'
Spec::Rake::SpecTask.new do |t|
  t.warning = true
  t.spec_files = FileList['spec/**/*spec.rb']
end

namespace :spec do
  desc 'Run application specs'
  Spec::Rake::SpecTask.new(:application) do |t|
    app = ENV['app']    
    tags = ENV['tag']
  
    file_pattern = "application_tests/**/#{app+'/**/' if app}*spec.rb"
  
    if tags
      tags = tags.split(',')
      t.spec_files = TestSweet::TagFilter.filter(file_pattern,tags)
    else
      t.spec_files = FileList[file_pattern]
    end
  
    t.verbose = true
  end
end