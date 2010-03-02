require File.join(File.dirname(__FILE__), 'test_helper')
require 'xebec'

class NavBarHelperTest < Test::Unit::TestCase
  
  context 'the NavBar Helper' do
    
    setup do
      @helper = new_nav_bar_helper
    end
    
    should 'return a NavBar proxy for :nav_bar' do
      assert @helper.nav_bar.kind_of?(Xebec::NavBarProxy)
    end
    
  end
  
end
