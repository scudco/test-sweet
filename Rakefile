# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './lib/test_sweet.rb'
require 'rake/testtask'

Hoe.new('test_sweet', TestSweet::VERSION) do |p|
  p.developer('Drew Olson', 'olsonas@gmail.com')
  p.extra_deps << ['need', '>= 1.0.2']
  p.extra_deps << ['rspec', '>= 1.1.3']
  p.extra_deps << ['block-chainable', '>= 0.0.3']
  p.extra_deps << ['ci_reporter', '>= 1.5.1']
  p.extra_deps << ['activesupport', '>= 2.0.2']
end

# vim: syntax=Ruby
