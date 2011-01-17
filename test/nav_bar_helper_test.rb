require File.join(File.dirname(__FILE__), 'test_helper')
require 'xebec'

class NavBarHelperTest < Test::Unit::TestCase
  
  context 'NavBarHelper#nav_bar' do
    
    setup do
      @helper = new_nav_bar_helper
    end
    
    should 'return a NavBar renderer' do
      assert @helper.nav_bar.kind_of?(Xebec::NavBarRenderer)
    end
    
    should 'use a custom renderer class if one is set' do
      begin
        @old_renderer_class = Xebec::renderer_class
        klass = Class.new do
          def initialize(*args, &block); end;
        end
        Xebec::renderer_class = klass
        assert @helper.nav_bar.kind_of?(klass)
      ensure
        Xebec::renderer_class = @old_renderer_class
      end
    end

    should 'use a custom renderer class if one is passed in' do
      begin
        @old_renderer_class = Xebec::renderer_class
        klass = Class.new do
          def initialize(*args, &block); end;
        end
        assert @helper.nav_bar(nil, {}, :renderer_class => klass).kind_of?(klass)
      ensure
        Xebec::renderer_class = @old_renderer_class
      end
    end    
    
    should 'return a NavBar with the given name' do
      assert_equal :snacks, @helper.nav_bar(:snacks).name
    end
    
    should 'return the same NavBar for repeated calls with the same name' do
      snacks = @helper.nav_bar(:snacks)
      assert_equal snacks, @helper.nav_bar(:snacks)
    end
    
    should 'treat Symbol names and String names equivalently' do
      desserts = @helper.nav_bar(:desserts)
      assert_equal desserts, @helper.nav_bar('desserts')
    end
    
    should 'allow additional HTML attributes' do
      salads = @helper.nav_bar(:salads, :id => 'salads-nav')
      assert_equal 'salads-nav', @helper.nav_bar(:salads).html_attributes[:id]
    end
    
    should "evaluate a block in the helper's scope" do
      @helper.expects(:zoink!)
      @helper.nav_bar do |bar|
        zoink!
      end
    end
    
    should "yield the NavBar renderer to the given block" do
      bar = @helper.nav_bar
      bar.expects :zoink!
      @helper.nav_bar do |nb|
        nb.zoink!
      end
    end
    
  end
  
  context 'NavBarHelper#nav_bar_unless_empty' do
    setup do
      @helper = new_nav_bar_helper
      @bar = @helper.nav_bar(:pets)
    end
    
    context 'with an empty navigation bar' do
      should 'return an empty String' do
        assert @helper.nav_bar_unless_empty(:pets).blank?
      end
    end
    
    context 'with a non-empty navigation bar' do
      setup { @bar.nav_item :cats, '/cats' }
      should 'return a navigation bar' do
        assert !@helper.nav_bar_unless_empty(:pets).blank?
      end
    end
  end
  
end
