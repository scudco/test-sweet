require 'rubygems'
require 'block_chainable'
require 'need'
need{'filter_error'}

module TestSweet
  class Page
    def self.inherited klass
      klass.class_eval do
        include BlockChainable
      end
    end
  
    def initialize
      # build methods for elements
      self.class.elements.each do |element,block|
        self.class.class_eval do
          define_method("__#{element}_block",&block)
          
          define_method(element) do |*args|
            if (self.class.filters[element].to_a + self.class.filters[:all].to_a).all?{|filter| instance_eval(&filter)}
              self.send("__#{element}_block",*args)
            else
              raise FilterError, "All filters for #{element} did not return true"
            end
          end
        end
      end
    end
  
    def browser
      @browser ||= @__parent.browser
    end
    
    def environment
      @environment ||= @__parent.environment
    end
    
    def self.filter *args,&block
      args.each do |element|
        if filters[element]
          filters[element] << block
        else
          filters[element] = [block]
        end
      end
    end
    
    def self.element name,&block
      elements[name] = block
    end
    
    private
    
    def self.filters
      @filters ||= {}
    end
    
    def self.elements
      @elements ||= {}
    end
  end
end