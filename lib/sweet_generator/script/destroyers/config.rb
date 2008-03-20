require 'rubygems'
require 'active_support/inflector'
require 'need'
need{'sweet_destroyer'}

module TestSweet
  class ConfigDestroyer < SweetDestroyer
    def initialize *args
      @site,@name = args
      
      unless @site && @name
        raise ArgumentError, 'you must provide a site and a name'
      end
    end
    
    def destroy
      config_file = File.join(File.dirname(__FILE__),'..','..','config',Inflector.underscore(@site),"#{@name}.yaml")
      unless File.exists? config_file
        raise ArgumentError, 'config specified does not exist'
      end
      remove_file config_file
    end
  end
end