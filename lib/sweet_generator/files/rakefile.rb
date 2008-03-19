require 'rake/testtask'
require 'spec/rake/spectask'
require 'fileutils'

desc 'Run current release functional tests'
task :test => ['test:release']

desc 'Run current release functional specs'
task :spec => ['spec:release']

namespace :test do
  desc 'Run current release functional tests'
  Rake::TestTask.new(:release) do |t|
    app = ENV['app']
    t.test_files = FileList["next_release/**/#{app+'/**/' if app}test*.rb"]
    t.verbose = true
  end
  
  desc 'Run regression functional tests'
  Rake::TestTask.new(:regression) do |t|
    app = ENV['app']
    release = ENV['release']
    t.test_files = FileList["regression/**/#{release+'/**/' if release}#{app+'/**/' if app}test*.rb"]
    t.verbose = true
  end
end

namespace :spec do
  desc 'Run current release functional specs'
  Spec::Rake::SpecTask.new(:release) do |t|
    app = ENV['app']
    t.spec_files = FileList["next_release/**/#{app+'/**/' if app}*spec.rb"]
    t.verbose = true
  end
  
  desc 'Run regression functional specs'
  Spec::Rake::SpecTask.new(:regression) do |t|
    app = ENV['app']
    release = ENV['release']
    t.spec_files = FileList["regression/**/#{release+'/**/' if release}#{app+'/**/' if app}*spec.rb"]
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