require 'rubygems'
require 'test_sweet'

module TestSweet
  APPLICATION_ROOT = File.expand_path(File.join(File.dirname(__FILE__),'..'))
  
  class Site
    # implement start_browser to create your browser instance. It should store
    # instance in @browser. Use values in @environment to initialize it.
    def start_browser
      @browser = Struct.new(:url).new(@environment['url'])
      start_page
    end
    
    # implement start_page to redirect an existing browser to your site's
    # start page
    def start_page
      
    end
  end
end

Dir.glob(File.join(TestSweet::APPLICATION_ROOT,'sites','*.rb')) do |site_file|
  require site_file
end