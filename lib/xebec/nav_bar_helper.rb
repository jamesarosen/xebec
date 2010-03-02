module Xebec
  
  module NavBarHelper
    
    def nav_bar
      return NavBarProxy.new(NavBar.new, self)
    end
    
  end
  
end
