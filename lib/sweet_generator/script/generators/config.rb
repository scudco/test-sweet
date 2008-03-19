require 'rubygems'
require 'active_support/inflector'
require 'need'
require 'yaml'
need{"sweet_generator"}

module TestSweet
  class ConfigGenerator < SweetGenerator
    def initialize *args
      @site,@name = args
      
      unless @site && @name
        raise ArgumentError, "please provide a site and config name"
      end
    end
    
    def generate
      file_dir = File.expand_path(File.dirname(__FILE__))

      config_dir = File.join(file_dir,"..","..","config",Inflector.underscore(@site))
      
      unless File.exist? config_dir
        raise ArgumentError, "site #{@blah} does not exist"
      end
      
      config_file = File.join(config_dir,"#{Inflector.underscore(@name)}.yaml")
      
      add_file config_file, YAML::dump({'sample_key' => 'sample value'})
    end
  end
end