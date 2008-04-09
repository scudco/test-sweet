#!/usr/bin/env ruby
require 'rubygems'
require 'need'
require 'active_support/inflector'
need{'sweet_generator'}

module TestSweet
  class TestGenerator < SweetGenerator
    def initialize(*args)
      @site, @name = args

      unless @site && @name
        raise ArgumentError, 'you must specify a site and name'
      end
    end
    
    def generate
      file_dir = File.expand_path(File.dirname(__FILE__))

      test_dir = File.join(file_dir,'..','..','next_release',@site)

      unless File.exist? test_dir
        raise ArgumentError, 'the specified site does not exist'
      end

      test_file = File.join(test_dir,"test_#{@name}.rb")

      add_file test_file, <<-EOS
require 'test/unit'
require 'rubygems'
require 'need'
need{'../../lib/application'}

class Test#{Inflector.camelize(@name)} < Test::Unit::TestCase
  def test_something
    #{Inflector.camelize(@site)} do
      start_browser

      assert true
    end
  end
end
      EOS
    end
  end
end