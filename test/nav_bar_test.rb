require File.join(File.dirname(__FILE__), 'test_helper')
require 'xebec'

class NavBarTest < Test::Unit::TestCase
  
  context 'a NavBar' do
    
    setup do
      @bar = Xebec::NavBar.new
    end
    
  end
  
end
