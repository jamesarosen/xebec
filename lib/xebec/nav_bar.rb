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
    
    # Add a navigation item to this bar.
    #
    # @param [String, Symbol] name the name of the item
    # @param [String, Proc] path the URL of the item; optional
    #
    # To customize the link text, set the internationalization key
    # <tt>navbar.{{nav bar name}}.{{nav item name}}</tt>.
    #
    # @see Xebec::NavBarHelper#nav_bar
    # @see Xebec::NavBarProxy#to_s
    def nav_item(name, path = nil)
      items << [name, path]
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
