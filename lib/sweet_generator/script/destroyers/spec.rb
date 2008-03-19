#!/usr/bin/env ruby
require 'rubygems'
require 'need'
require 'active_support/inflector'
need{"sweet_destroyer"}

module TestSweet
  class SpecDestroyer < SweetDestroyer
    def initialize *args
      @site,@name = args

      unless @site && @name
        raise ArgumentError, "you must specify a site and name"
      end
    end
    
    def destroy
      file_dir = File.expand_path(File.dirname(__FILE__))

      spec_dir = File.join(file_dir,"..","..","next_release",@site)

      unless File.exist? spec_dir
        raise ArgumentError, "the specified site does not exist"
      end

      spec_file = File.join(spec_dir,"#{@name}_spec.rb")

      remove_file spec_file
    end
  end
end