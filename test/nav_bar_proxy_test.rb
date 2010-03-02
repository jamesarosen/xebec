require File.join(File.dirname(__FILE__), 'test_helper')
require 'xebec'

class NavBarProxyTest < Test::Unit::TestCase
  
  context 'creating a NavBar proxy' do
    should 'require a NavBar' do
      assert_raises(ArgumentError) do
        Xebec::NavBarProxy.new('foobar', new_nav_bar_helper)
      end
    end
    should 'require a NavBarHelper' do
      assert_raises(ArgumentError) do
        Xebec::NavBarProxy.new(Xebec::NavBar.new, 'baz')
      end
    end
  end
  
  context 'a NavBar proxy' do
    
    setup do
      @bar = Xebec::NavBar.new
      @helper = new_nav_bar_helper
      @proxy = Xebec::NavBarProxy.new(@bar, @helper)
    end
    
    context 'with an empty NavBar' do
    
      should 'render an empty navigation bar' do
        assert_equal '<ul class="navbar" />', @proxy.to_s
      end
      
    end
    
  end
  
end
