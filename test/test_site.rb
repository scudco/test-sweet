require 'test/unit'
require 'rubygems'
require 'mocha'
require 'need'
require 'block_chainable'
need{'../lib/test_sweet'}

module TestSweet
  APPLICATION_ROOT = File.dirname(__FILE__)
end

class FooSite < TestSweet::Site; end

class TestSite < Test::Unit::TestCase
  def test_flow
    FooSite.any_instance.stubs(:load_pages)
    FooSite.any_instance.stubs(:load_flows)
    FooSite.any_instance.stubs(:load_config)
    
    FooSite.flow :hello do
      "hello"
    end
    
    assert_equal "hello",FooSite.new.hello
  end
  
  def test_flow_with_arguments
    FooSite.any_instance.stubs(:load_pages)
    FooSite.any_instance.stubs(:load_flows)
    FooSite.any_instance.stubs(:load_config)
    
    FooSite.flow :return_me do |arg|
      arg
    end
    
    assert_equal :test, FooSite.new.return_me(:test)
  end
  
  def test_load_pages
    FooSite.any_instance.stubs(:load_flows)
    FooSite.any_instance.stubs(:load_config)
    
    foo = FooSite.new
    
    assert foo.page_loaded?
  end
  
  def test_load_flows
    FooSite.any_instance.stubs(:load_pages)
    FooSite.any_instance.stubs(:load_config)
    
    foo = FooSite.new
    
    assert foo.flow_loaded?
  end
  
  def test_load_config_default
    FooSite.any_instance.stubs(:load_pages)
    FooSite.any_instance.stubs(:load_flows)
    
    foo = FooSite.new
    
    assert_equal 'test_value', foo.environment['test_key']
  end
  
  def test_load_config_FooSite
    ENV['config'] = 'foo'
    
    FooSite.any_instance.stubs(:load_pages)
    FooSite.any_instance.stubs(:load_flows)
    
    foo = FooSite.new
    
    assert_equal 'foo_value', foo.environment['foo_key']
    
    ENV['config'] = nil
  end
  
  def test_bad_config
    FooSite.any_instance.stubs(:load_pages)
    FooSite.any_instance.stubs(:load_flows)
    
    ENV['config'] = 'bad_value'
    
    assert_raises ArgumentError do
      FooSite.new
    end
    
    ENV['config'] = nil
  end
  
  def test_block_chainable_is_extended_when_site_is_inherited
    assert(FooSite.included_modules.include?(BlockChainable))
  end
  
  def test_site_within_site_gets_parents_browser
    FooSite do
      @browser = :test
      
      FooSite do
        assert_equal :test, browser
      end
    end
  end
end