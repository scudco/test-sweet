require 'rubygems'
require 'block_chainable'
require 'need'
need{'filter_error'}

module TestSweet
  class Page
    include BlockChainable
      
    def self.filter(*elements,&block)
      elements.each do |element|
        (filters[element] ||= []) << block
      end
    end
    
    def self.element(name,&block)
      elements[name] = block
    end
    
    def self.elements(hash=nil)
      if hash
        hash.each{|key,val| elements[key] = val}
      else
        @elements ||= {}
      end
    end
    
    def self.filters
      @filters ||= {}
    end
      
    def initialize
      # build methods for elements
      self.class.elements.each do |element,block|
        self.class.send(:define_method,"__#{element}_block",&block)
        
        self.class.send(:define_method,element) do |*args|
          if (self.class.filters[:all].to_a + self.class.filters[element].to_a).all?{|filter| instance_eval(&filter)}
            self.send("__#{element}_block",*args)
          else
            raise FilterError, "All filters for #{element} did not return true"
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
  end
end