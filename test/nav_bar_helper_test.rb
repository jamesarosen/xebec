require File.join(File.dirname(__FILE__), 'test_helper')
require 'xebec'

class NavBarHelperTest < Test::Unit::TestCase
  
  context 'NavBarHelper#nav_bar' do
    
    setup do
      @helper = new_nav_bar_helper
    end
    
    should 'return a NavBar proxy' do
      assert @helper.nav_bar.kind_of?(Xebec::NavBarProxy)
    end
    
    should 'return a NavBar with the given name' do
      assert_equal :snacks, @helper.nav_bar(:snacks).name
    end
    
    should 'return the same NavBar for repeated calls with the same name' do
      snacks = @helper.nav_bar(:snacks)
      assert_equal snacks, @helper.nav_bar(:snacks)
    end
    
    should "evaluate a block in the NavBar's scope" do
      bar = @helper.nav_bar
      bar.stubs(:zoink!)
      @helper.nav_bar do
        zoink!
      end
      assert_received(bar, :zoink!)
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
