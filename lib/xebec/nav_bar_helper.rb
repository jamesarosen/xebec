module Xebec
  
  module NavBarHelper
    
    # If called in an output expression ("<%= navbar %>" in ERB
    # or "=navbar" in HAML), renders the navigation bar.
    #
    # Example:
    # 
    #   <%= navbar %>
    #   # => <ul class="navbar">...</ul>
    #
    # @see Xebec::NavBarProxy#to_s
    # 
    # If called with a block, yields the underlying NavBar for
    # modification.
    #
    # Example:
    #
    #   <% navbar do
    #     nav_item :home
    #     nav_item :faq, pages_path(:page => :faq)
    #   end %>
    #
    # @see Xebec::NavBar#nav_item
    def nav_bar(name = Xebec::NavBar::DEFAULT_NAME)
      nav_bars[name] ||= NavBarProxy.new(NavBar.new(name), self)
    end
    
    protected
    
    def nav_bars
      @nav_bars ||= {}
    end
    
  end
  
end
