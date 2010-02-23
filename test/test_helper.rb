require 'test/unit'
require 'test/unit/testcase'
require 'rubygems'
require 'shoulda'
require 'mocha'
require 'redgreen'

[['..', 'lib'], ['lib']].each do |lib_dir|
  lib_path = File.expand_path(File.join(File.dirname(__FILE__), *lib_dir))
  $: << lib_path unless $:.include?(lib_path)
end

require 'xebec'
