= test_sweet

* http://rubyforge.org/projects/test-sweet/

== DESCRIPTION:

 Test Sweet is a framework for building and maintaining functional test suites written
 in ruby. It works on the principle of convention over configuration popularized
 by Rails. This enables testers to get started writing tests quickly and enforces 
 naming and directory hierarchy standards that help understanding by creating a
 uniform base. 

 The framework itself, through the use of generators is responsible for creating 
 the classes and structure necessary to support your tests. Test Sweet comes with 
 out of the box support for both RSpec and Test::Unit. 

 Tests can be set to run with Watir, FireWatir or Selenium RC. Test Sweet supports 
 filtering tests based on user specified tags. Test results are created with
 ci_reporter as xml artifacts which can be picked up by Cruise Control or other
 Continuous Integration servers.


== FEATURES/PROBLEMS:

* FIX (list of features or problems)

== SYNOPSIS:

  To create a new test project, open a command prompt and type 'sweet <application name>'. 
  Test Sweet will generate a basic skeleton structure to use for your application tests
  in the directory where you've run the command. 

== REQUIREMENTS:
* rspec or test::unit to run tests
* need
* block-chainable
* ci_reporter
* activesupport
* mocha(optional) to run the unit tests

== INSTALL:

* sudo gem install test-sweet on OS X
* gem install on Windows

== LICENSE:

(The MIT License)

Copyright (c) 2008 FIX

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
