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
      @bar = Xebec::NavBar.new('elephants')
      @helper = new_nav_bar_helper
      @proxy = Xebec::NavBarProxy.new(@bar, @helper)
    end
    
    should 'respond to :name' do
      assert @proxy.respond_to?(:name)
    end
    
    should "return the NavBar's name when sent :name" do
      assert_equal 'elephants', @proxy.name
    end
    
    should 'not respond to a method that the underlying NavBar does not' do
      assert !@proxy.respond_to?(:cromulize)
    end
    
    context 'with an empty NavBar' do
    
      should 'render an empty navigation bar' do
        assert_equal '<ul class="navbar" />', @proxy.to_s
      end
      
    end
    
  end
  
end
