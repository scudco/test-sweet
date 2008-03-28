require 'test/unit'
require 'rubygems'
require 'mocha'
require 'block_chainable'
require 'need'
need{'../lib/test_sweet'}

class SomePage < TestSweet::Page
  element :test do
    :test
  end
  
  element :test_true do
    :test_true
  end
  
  element :test_false do
    :test_false
  end
  
  elements :return_me => proc{|val| val},
           :call_helper => proc{helper}
  
  filter :a, :b do
    "foo"
  end
  
  filter :b do
    "bar"
  end
  
  filter :test_true do
    true
  end
  
  filter :test_false do
    false
  end
  
  def helper
    :helper
  end
end

class TestPage < Test::Unit::TestCase
  def test_browser_calls_parent_when_nil
    page = TestSweet::Page.new
    parent_mock = mock
    parent_mock.expects(:browser)
    page.instance_variable_set("@__parent",parent_mock)
    page.browser
  end
  
  def test_environment_calls_parent_when_nil
    page = TestSweet::Page.new
    parent_mock = mock
    parent_mock.expects(:environment)
    page.instance_variable_set("@__parent",parent_mock)
    page.environment
  end
  
  def test_browser_does_not_call_parent_when_not_nil
    page = TestSweet::Page.new
    page.instance_variable_set("@browser",:browser)
    assert_equal :browser, page.browser
  end
  
  def test_enviroment_does_not_call_parent_when_not_nil
    page = TestSweet::Page.new
    page.instance_variable_set("@environment",:environment)
    assert_equal :environment, page.environment
  end
  
  def test_block_chainable_is_extended_when_page_is_inherited
    assert(SomePage.included_modules.include?(BlockChainable))
  end
  
  def test_filter_for_a
    assert_equal "foo",SomePage.filters[:a].first.call
  end
  
  def test_first_filter_for_b
    assert_equal "foo",SomePage.filters[:b].first.call
  end
  
  def test_second_filter_for_b
    assert_equal "bar",SomePage.filters[:b][1].call
  end
  
  def test_element_with_no_filter
    assert_equal :test, SomePage.new.test
  end
  
  def test_element_with_true_filter
    assert_equal :test_true, SomePage.new.test_true
  end
  
  def test_element_with_false_filter
    assert_raises TestSweet::FilterError do
      SomePage.new.test_false
    end
  end
  
  def test_non_existant_element
    assert_raises NoMethodError do
      SomePage.new.bad_method
    end
  end
  
  def test_element_with_arguments
    assert_equal :test, SomePage.new.return_me(:test)
  end
  
  def test_element_with_instance_binding
    assert_equal :helper, SomePage.new.call_helper
  end
end