# Rails uses rails/init.rb, not this file. Put any Rails-specific
# initialization in that file.

lib_path = File.expand_path(File.join(File.dirname(__FILE__), 'lib'))
$: << lib_path unless $:.include?(lib_path)

require 'xebec'
