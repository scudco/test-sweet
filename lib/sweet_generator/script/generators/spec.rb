#!/usr/bin/env ruby
require 'rubygems'
require 'need'
require 'active_support/inflector'
need{'sweet_generator'}

module TestSweet
  class SpecGenerator < SweetGenerator
    def initialize *args
      @site, @name = args

      unless @site && @name
        raise ArgumentError, 'you must specify a site and name'
      end
    end
    
    def generate
      file_dir = File.expand_path(File.dirname(__FILE__))

      spec_dir = File.join(file_dir,'..','..','next_release',@site)

      unless File.exist? spec_dir
        raise ArgumentError, 'the specified site does not exist'
      end

      spec_file = File.join(spec_dir,"#{@name}_spec.rb")

      add_file spec_file, <<-EOS
require 'rubygems'
require 'need'
require 'spec'
need{'../../lib/application'}

describe "description here" do
  it "should do something" do
    #{Inflector.camelize(@site)} do
      start_browser

      true.should == true
    end
  end
end
        EOS
    end
  end
end