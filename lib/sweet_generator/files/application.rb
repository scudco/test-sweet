require 'rubygems'
require 'test_sweet'

module TestSweet
  APPLICATION_ROOT = File.expand_path(File.join(File.dirname(__FILE__),'..'))
  
  class Site
    # implement start_browser to create your browser instance. It should assign
    # the instance using self.browser = instance. See below for trivial example.
    def start_browser
      # browser being created as a Struct
      self.browser = Struct.new(:url).new(environment['url'])
      
      # examples below for starting Selenium and Watir. Both depend on the url
      # field being set in your site config/default.yaml to the base url of the 
      # site.
      
      # example of browser being created as a Watir::IE instance
      #  self.browser = Watir::IE.new
      
      # example of browser being created as a Selenium firefox instance
      #  self.browser = Selenium::SeleniumDriver.new("localhost", 4444, "*chrome", environment['url'], 30000)
      
      # open the browser at your start page
      start_page
    end
    
    # implement start_page to redirect an existing browser to your site's
    # start page
    def start_page
      # browser being redirected to start page using Watir
      # browser.start(environment['url'])
      
      # browser being redirected to start page using selenium
      # browser.open('/')
    end
  end
end

# require all existing site files
Dir.glob(File.join(TestSweet::APPLICATION_ROOT,'sites','*.rb')) do |site_file|
  require site_file
end