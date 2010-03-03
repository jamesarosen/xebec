require 'test/unit'
require 'test/unit/testcase'
require 'rubygems'
require 'shoulda'
require 'mocha'
require 'activesupport'
require 'actionpack'
require 'action_view'
require 'action_controller'

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
  include ActionController::Assertions::SelectorAssertions
  
  def assert_select_from(text, *args, &block)
    @selected = HTML::Document.new(text).root.children
    assert_select(*args, &block)
  end
  
  def new_nav_bar_helper
    ActionView::Base.new.tap do |helper|
      helper.extend Xebec::NavBarHelper
    end
  end
  
  def clear_translations!
    I18n.reload!
  end

  def define_translation(key, value)
    hash = key.to_s.split('.').reverse.inject(value) do |value, key_part|
      { key_part.to_sym => value }
    end
    I18n.backend.send :merge_translations, I18n.locale, hash
  end
end
