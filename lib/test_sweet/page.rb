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
  
    def browser
      @browser ||= @__parent.browser
    end
    
    def environment
      @environment ||= @__parent.environment
    end
    
    def method_missing name,*args
      if self.class.elements.include? name
        if (self.class.filters[name].to_a + self.class.filters[:all].to_a).all?{|filter| instance_eval(&filter)}
          self.class.elements[name].call(*args)
        else
          raise FilterError, "All filters for #{name} did not return true"
        end
      else
        super
      end
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