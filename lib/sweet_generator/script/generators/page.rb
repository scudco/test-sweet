#!/usr/bin/env ruby
require 'rubygems'
require 'active_support/inflector'
require 'need'
need{"sweet_generator"}

module TestSweet
  class PageGenerator < SweetGenerator
    def initialize(*args)
      @site, @name = args

      unless @site && @name
        raise ArgumentError, 'you must provide a site and a page'
      end
    end
    
    def generate
      file_dir = File.expand_path(File.dirname(__FILE__))
      
      page_dir = File.join(file_dir,'..','..','pages',"#{Inflector.underscore(@site)}")

      unless File.exist? page_dir
        raise ArgumentError, "#{@site} is not a valid site"
      end

      page_file = File.join(page_dir,"#{Inflector.underscore(@name)}.rb")

      add_file page_file,<<-EOS
require 'rubygems'
require 'test_sweet'

class #{Inflector.camelize(@name)} < TestSweet::Page

end
        EOS
    end
  end
end