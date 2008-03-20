require 'yaml'
require 'rubygems'
require 'block_chainable'
require 'active_support/inflector'

module TestSweet
  class Site
    attr_reader :environment
    
    def self.inherited klass
      klass.class_eval do
        include BlockChainable
      end
    end
  
    def self.flow name,&block
      self.class_eval do
        define_method(name,&block)
      end
    end
  
    def initialize
      load_pages
      load_flows
      load_config
    end
    
    def browser
      if !(@browser ||= nil) && @__parent && @__parent.respond_to?(:browser)
        @browser = @__parent.browser
      end
      
      @browser
    end
    
    def browser=(val)
      if @__parent && !@__parent.respond_to?(:browser)
        class << @__parent
          define_method(:browser) do
            val
          end
        end
      end
      
      @browser = val
    end
    
    private
    
    def load_pages
      load_files 'pages'
    end
    
    def load_flows
      load_files 'flows'
    end
    
    def load_files dir
      Dir.glob(File.join(APPLICATION_ROOT,dir,Inflector.underscore(self.class.to_s),'**','*.rb')) do |page_file|
        require page_file
      end
    end
    
    def load_config
      yaml_file = File.join(APPLICATION_ROOT,'config',Inflector.underscore(self.class.to_s),"#{ENV['config'] || "default"}.yaml")
      
      if File.exist? yaml_file
        @environment = YAML::load(File.read(yaml_file))
      else
        raise ArgumentError, "config file does not exist: #{yaml_file}"
      end
    end
  end
end