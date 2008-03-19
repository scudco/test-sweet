require 'yaml'
require 'rubygems'
require 'block_chainable'
require 'active_support/inflector'

module TestSweet
  class Site
    attr_reader :browser, :environment
    
    def self.inherited klass
      klass.class_eval do
        include BlockChainable
      end
    end
  
    def self.flow name,&block
      self.class_eval do
        define_method(name) do |*args|
          self.instance_eval do
            block.call(*args)
          end
        end
      end
    end
  
    def initialize
      load_pages
      load_flows
      load_config
    end
    
    def start_browser
      # impelement this line to instantiate your browser object and start it
      # using the url provided by @enviornment
      @browser = Struct.new(:url).new(@environment['url'])
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