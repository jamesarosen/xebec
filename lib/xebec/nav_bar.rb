module Xebec
  
  class NavBar
    
    attr_reader :name
    attr_reader :items
    
    # Create a new NavBar object.
    #
    # @param [String] name the name of the navigation bar; defaults to :default
    def initialize(name = nil)
      @name = name || :default
      @items = []
    end
    
    def nav_item(name)
      items << name
    end
    
    def empty?
      items.empty?
    end
    
    def to_s
      "<NavBar #{name}>"
    end
    
    def inspect
      to_s
    end
    
  end
  
end
