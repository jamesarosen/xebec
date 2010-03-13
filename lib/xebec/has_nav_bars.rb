require 'xebec/nav_bar'

module Xebec
  
  # A supporting mixin for NavBarHelper and ControllerSupport.
  # Looks up navigation bars by name.
  module HasNavBars #:nodoc:
    
    protected
    
    # Looks up the named nav bar, creates it if it
    # doesn't exist, and evaluates the the block, if
    # given, in the scope of +self+, yielding the nav bar.
    #
    # @param [Symbol, String] name the name of the navigation bar to look up
    # @param [Hash] html_attributes additional HTML attributes to add to the
    #                               navigation bar
    def look_up_nav_bar_and_eval(name = nil, html_attributes = {}, &block)
      name ||= Xebec::NavBar::DEFAULT_NAME
      look_up_nav_bar(name, html_attributes).tap do |bar|
        block.bind(self).call(bar) if block_given?
      end
    end
    
    def look_up_nav_bar(name, html_attributes)
      (nav_bars[name] ||= NavBar.new(name, html_attributes)).tap do |bar|
        bar.html_attributes.merge!(html_attributes)
      end
    end
    
    def nav_bars
      @nav_bars ||= HashWithIndifferentAccess.new
    end
    
  end
  
end
