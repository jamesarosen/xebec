require 'test/unit'
require 'test/unit/testcase'
require 'rubygems'
require 'shoulda'
require 'mocha'
require 'activesupport'
require 'actionpack'
require 'action_view'

begin
  require 'redgreen/unicode'
rescue
  require 'redgreen'
end

[['..', 'lib'], ['lib']].each do |lib_dir|
  lib_path = File.expand_path(File.join(File.dirname(__FILE__), *lib_dir))
  $: << lib_path unless $:.include?(lib_path)
end

require 'xebec'

Test::Unit::TestCase.class_eval do
  def new_nav_bar_helper
    Object.new.tap do |helper|
      helper.extend ::ActionView::Helpers::TagHelper
      helper.extend ::ActionView::Helpers::UrlHelper
      helper.extend Xebec::NavBarHelper
    end
  end
end
