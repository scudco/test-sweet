require 'rubygems'
require 'need'
need{'../../../lib/test_sweet'}

class FooSite < TestSweet::Site
  def page_loaded?
    true
  end
end