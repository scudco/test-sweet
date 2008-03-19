#!/usr/bin/env ruby
require 'fileutils'
require 'rubygems'
require 'need'
require 'active_support/inflector'
need{"sweet_destroyer"}

module TestSweet
  class SiteDestroyer < SweetDestroyer
    def initialize *args
      @name = args[0]

      unless @name
        raise ArgumentError, "Please specify a name for your site to destroy"
      end
    end
    
    def destroy
      file_dir = File.expand_path(File.dirname(__FILE__))
      
      site_file = File.join(file_dir,"..","..","sites","#{Inflector.underscore(@name)}.rb")

      if File.exist? site_file
        remove_file site_file
      end

      ["pages","config","flows"].each do |dir|
        remove_dir File.join(file_dir,"..","..",dir,Inflector.underscore(@name))
      end
    end
  end
end