require "test/unit"
require 'rubygems'
require 'need'
need {'../lib/test_sweet/tag_filter'}

class TestTagFilter < Test::Unit::TestCase
  def test_tag_a
    pattern = File.dirname(__FILE__) + "/tag_files/*.rb"
    assert_equal 2, TestSweet::TagFilter.filter(pattern,['a']).size
  end
  
  def test_tag_b
    pattern = File.dirname(__FILE__) + "/tag_files/*.rb"
    assert_equal 2, TestSweet::TagFilter.filter(pattern,['b']).size
  end
  
  def test_tags_a_and_b
    pattern = File.dirname(__FILE__) + "/tag_files/*.rb"
    assert_equal 1, TestSweet::TagFilter.filter(pattern,['a','b']).size
  end
end