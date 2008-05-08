require "test/unit"
require "rubygems"
require 'need'
need {'../lib/test_sweet/tag'}

class TestTag < Test::Unit::TestCase
  def test_tag
    assert_nothing_raised do
      TestSweet.tag :foo
    end
  end
end