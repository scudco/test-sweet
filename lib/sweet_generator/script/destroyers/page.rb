#!/usr/bin/env ruby
require 'rubygems'
require 'need'
require 'active_support/inflector'
need{'sweet_destroyer'}

module TestSweet
  class PageDestroyer < SweetDestroyer
    def initialize(*args)
      @site, @name = args

      unless @name && @site
        raise ArgumentError, 'you must provide a site and a page'
      end
    end
    
    def destroy
      file_dir = File.expand_path(File.dirname(__FILE__))

      page_file = File.join(file_dir,'..','..','pages',Inflector.underscore(@site),"#{@name}.rb")

      unless File.exists? page_file
        raise ArgumentError, 'page specified does not exist'
      end

      remove_file page_file
    end
  end
end