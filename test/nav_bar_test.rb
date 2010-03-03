require File.join(File.dirname(__FILE__), 'test_helper')
require 'xebec'

class NavBarTest < Test::Unit::TestCase
  
  context 'a NavBar' do
    
    setup do
      @bar = Xebec::NavBar.new
    end
    
    should 'use :default as its name by default' do
      assert_equal :default, @bar.name
    end
    
    should 'use a specified name' do
      assert_equal 'fazbot', Xebec::NavBar.new('fazbot').name
    end
    
    should 'be empty by default' do
      assert @bar.empty?
    end
    
    context 'with some items' do
      setup do
        @bar.nav_item :foo
        @bar.nav_item :bar
      end
      should 'not be empty' do
        assert !@bar.empty?
      end
    end
    
  end
  
end
