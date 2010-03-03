module Xebec
  
  class NavItem
    
    attr_reader :name, :href
    
    def initialize(name, href = nil)
      @name, @href = name, href
    end
    
  end
  
end
