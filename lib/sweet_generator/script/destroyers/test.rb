#!/usr/bin/env ruby
require 'rubygems'
require 'need'
require 'active_support/inflector'
need{'sweet_destroyer'}

module TestSweet
  class TestDestroyer < SweetDestroyer
    def initialize(*args)
      @site,@name = args

      unless @name && @site
        raise ArgumentError, 'you must specify a site and name'
      end
    end
    
    def destroy
      file_dir = File.expand_path(File.dirname(__FILE__))

      test_dir = File.join(file_dir,'..','..','application_tests',@site)

      unless File.exist? test_dir
        raise ArgumentError, 'the specified site does not exist'
      end

      test_file = File.join(test_dir,"test_#{Inflector.underscore(@name)}.rb")

      unless File.exist? test_file
        raise ArgumentError, 'the specified test does not exist'
      end
      
      remove_file test_file
    end
  end
end