require File.join(File.dirname(__FILE__), 'test_helper')
require 'xebec'

class ControllerSupportTest < Test::Unit::TestCase
  
  def setup
    @controller_class = Class.new(ActionController::Base).tap do |c|
      c.instance_eval do
        include Xebec::ControllerSupport
        def public_nav_bar(*args, &block)
          nav_bar(*args, &block)
        end
      end
    end
    @controller = @controller_class.new
  end
  
  def call_before_filters
    @controller_class.before_filters.each do |filter|
      filter.call(@controller)
    end
  end
  
  context 'ControllerSupport::ClassMethods#nav_bar' do
    
    should 'append a before_filter that looks up the named navigation bar' do
      @controller_class.public_nav_bar :turtles
      @controller.expects(:nav_bar).with(:turtles)
      call_before_filters
    end
    
    should 'append a before_filter with the given options' do
      options = { :only => :show }
      @controller_class.expects(:append_before_filter).with(options)
      @controller_class.public_nav_bar :foo, options
    end
  
    should 'append a before_filter that passes the given block to the named nav bar instance' do
      @controller_class.public_nav_bar(:baz) { |nb| nb.nav_item :help }
      bar = @controller.nav_bar :baz
      bar.expects(:nav_item).with(:help)
      call_before_filters
    end
    
  end
  
end
