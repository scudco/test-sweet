#!/usr/bin/env ruby
require 'rubygems'
require 'active_support/inflector'
require 'need'
require 'fileutils'
need{'sweet_destroyer'}

module TestSweet
  class FlowDestroyer < SweetDestroyer
    def initialize(*args)
      @site, @name = args
      
      unless @site && @name
        raise ArgumentError, 'please provide a site and flow name'
      end
    end
    
    def destroy
      file_dir = File.expand_path(File.dirname(__FILE__))

      flow_file = File.join(file_dir,'..','..','flows',Inflector.underscore(@site),"#{@name}.rb")

      unless File.exists? flow_file
        raise ArgumentError, 'specified flow does not exist'
      end
      
      remove_file flow_file
    end
  end
end