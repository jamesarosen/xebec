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
    def nav_bar(name = nil, &block)
      look_up_nav_bar(name).tap do |bar|
        bar.instance_eval &block if block_given?
      end
    end
    
    # Renders a navigation bar if and only if it contains any
    # navigation items. Unlike +nav_bar+, this method does not
    # accept a block.
    def nav_bar_unless_empty(name = nil)
      bar = look_up_nav_bar(name)
      bar.empty? ? '' : bar
    end
    
    protected
    
    def look_up_nav_bar(name = nil)
      name ||= Xebec::NavBar::DEFAULT_NAME
      nav_bars[name] ||= NavBarProxy.new(NavBar.new(name), self)
    end
    
    def nav_bars
      @nav_bars ||= {}
    end
    
  end
  
end
