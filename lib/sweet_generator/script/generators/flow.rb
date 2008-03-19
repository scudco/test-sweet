#!/usr/bin/env ruby
require 'rubygems'
require 'active_support/inflector'
require 'need'
require 'fileutils'
need{"sweet_generator"}

module TestSweet
  class FlowGenerator < SweetGenerator
    def initialize *args
      @site, @name = args

      unless @site && @name
        raise ArgumentError, "please provide a site and flow name"
      end
    end
    
    def generate
      file_dir = File.expand_path(File.dirname(__FILE__))

      flow_dir = File.join(file_dir,"..","..","flows",Inflector.underscore(@site))

      unless File.exist? flow_dir
        raise ArgumentError, "site specified does not exist"
      end

      flow_file = File.join(flow_dir,"#{Inflector.underscore(@name)}.rb")

      add_file flow_file, <<-EOS
#{Inflector.camelize(@site)}.flow :#{@name} do
  #{Inflector.camelize(@site)} do

  end
end
        EOS
    end
  end
end