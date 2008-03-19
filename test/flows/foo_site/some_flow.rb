require 'rubygems'
require 'need'
need{'../../../lib/test_sweet'}

class FooSite < TestSweet::Site
  def flow_loaded?
    true
  end
end