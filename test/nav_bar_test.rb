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
    
  end
  
end
