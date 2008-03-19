#!/usr/bin/env ruby
require 'rubygems'
require 'active_support/inflector'
require 'need'
require 'yaml'
need{"sweet_generator"}

module TestSweet
  class SiteGenerator < SweetGenerator
    def initialize *args
      @name = args[0]
      @default_config = {}
      
      unless @name
        raise ArgumentError, "please specify a name for your site"
      end
      
      if args.size > 1
        parse_configuration_arguments args[1..-1]
      end
    end
    
    def generate
      file_dir = File.expand_path(File.dirname(__FILE__))
      site_file_path = File.join(file_dir,"..","..","sites","#{Inflector.underscore(@name)}.rb")
      
      if File.exists? site_file_path
        raise ArgumentError, "A site with name #{@name} already exists"
      end
      
      add_file site_file_path, <<-EOS
require 'rubygems'
require 'test_sweet'

class #{Inflector.camelize(@name)} < TestSweet::Site; end
      EOS
      
      ["pages","flows","config","next_release"].each do |dir|
        site_dir = File.join(file_dir,"..","..",dir,"#{Inflector.underscore(@name)}")

        unless File.exist? site_dir
          make_dir site_dir
        end

        if dir == "config"
          if !@default_config.empty?
            add_file File.join(site_dir,"default.yaml"),YAML::dump(@default_config)
          else
            add_file File.join(site_dir,"default.yaml"),YAML::dump({"sample_key" => "sample value"})
          end
        end
      end
    end
    
    private
    
    def parse_configuration_arguments args
      args.each do |arg|
        @default_config[arg[/^(\w+):(.+)\Z/,1]] = arg[/^(\w+):(.+)\Z/,2]
      end
    end
  end
end