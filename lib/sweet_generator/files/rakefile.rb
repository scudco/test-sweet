require 'rubygems'
gem 'ci_reporter'
require 'ci/reporter/rake/rspec'
require 'ci/reporter/rake/test_unit'
require 'rake/testtask'
require 'spec/rake/spectask'
require 'fileutils'
require 'test_sweet/tag_filter'

desc 'Run current release functional tests'
task :test => ['test:release']

desc 'Run current release functional specs'
task :spec => ['spec:release']

namespace :test do
  desc 'Run current release functional tests'
  Rake::TestTask.new(:release) do |t|
    app = ENV['app']
    tags = ENV['tag']
    
    file_pattern = "next_release/**/#{app+'/**/' if app}test*.rb"
    
    if tags
      tags = tags.split(',')
      t.test_files = TestSweet::TagFilter.filter(file_pattern,tags)
    else
      t.test_files = FileList[file_pattern]
    end
    
    t.verbose = true
  end
  
  desc 'Run regression functional tests'
  Rake::TestTask.new(:regression) do |t|
    app = ENV['app']
    release = ENV['release']
    tags = ENV['tag']
    
    file_pattern = "regression/**/#{release+'/**/' if release}#{app+'/**/' if app}test*.rb"
    
    if tags
      tags = tags.split(',')
      t.test_files = TestSweet::TagFilter.filter(file_pattern,tags)
    else
      t.test_files = FileList[file_pattern]
    end
    
    t.verbose = true
  end
end

namespace :spec do
  desc 'Run current release functional specs'
  Spec::Rake::SpecTask.new(:release) do |t|
    app = ENV['app']    
    tags = ENV['tag']
    
    file_pattern = "next_release/**/#{app+'/**/' if app}*spec.rb"
    
    if tags
      tags = tags.split(',')
      t.spec_files = TestSweet::TagFilter.filter(file_pattern,tags)
    else
      t.spec_files = FileList[file_pattern]
    end
    
    t.verbose = true
  end
  
  desc 'Run regression functional specs'
  Spec::Rake::SpecTask.new(:regression) do |t|
    app = ENV['app']
    release = ENV['release']
    tags = ENV['tag']
    
    file_pattern = "regression/**/#{release+'/**/' if release}#{app+'/**/' if app}*spec.rb"
    
    if tags
      tags = tags.split(',')
      t.spec_files = TestSweet::TagFilter.filter(file_pattern,tags)
    else
      t.spec_files = FileList[file_pattern]
    end
    
    t.verbose = true
  end
end

desc 'Move tests from next_release into regression'
task :branch do
  unless ENV['version']
    puts 'Please specifiy a version for the branch'
  else
    version = ENV['version'].gsub(".","_")
    if File.exist?("regression/#{version}")
      puts "Branch version #{ENV['version']} already exists"
    else
      puts 'Creating new branch in regression...'
      FileUtils.mkdir("regression/#{version}")
      puts 'Moving files from next_release to new branch...'
      FileUtils.cp_r("next_release/.","regression/#{version}")
      puts 'Cleaning next_release...'
      FileUtils.rm_r(Dir.glob("next_release/*"))
      puts 'Complete!'
    end
  end
end