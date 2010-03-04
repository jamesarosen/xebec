require 'xebec/nav_bar'
require 'xebec/nav_bar_proxy'
require 'xebec/has_nav_bars'

module Xebec
  
  module NavBarHelper
    
    include Xebec::HasNavBars
    
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
    # @see Xebec::HasNavBars#nav_bar
    #
    # @return [Xebec::NavBarProxy]
    def nav_bar(name = nil, &block)
      look_up_nav_bar_and_eval name, &block
    end
    
    # Renders a navigation bar if and only if it contains any
    # navigation items. Unlike +nav_bar+, this method does not
    # accept a block.
    #
    # @return [String, Xebec::NavBarProxy]
    def nav_bar_unless_empty(name = nil)
      bar = look_up_nav_bar name
      bar.empty? ? '' : bar
    end
    
    protected
    
    # Override HasNavBars#look_up_nav_bar to replace with a
    # proxy if necessary.
    def look_up_nav_bar(name)
      bar = super(name)
      if bar.kind_of?(Xebec::NavBar)
        bar = nav_bars[bar.name] = NavBarProxy.new(bar, self)
      end
      bar
    end
    
  end
  
end
