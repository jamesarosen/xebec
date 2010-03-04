require 'xebec/nav_bar'

module Xebec
  
  # A supporting mixin for NavBarHelper and ControllerSupport.
  # Looks up navigation bars by name.
  module HasNavBars #:nodoc:
    
    protected
    
    # Looks up the named nav bar, creates it if it
    # doesn't exist, and evaluates the the block, if
    # given, in the scope of +self+, yielding the nav bar.
    def look_up_nav_bar_and_eval(name = nil, &block)
      name ||= Xebec::NavBar::DEFAULT_NAME
      look_up_nav_bar(name).tap do |bar|
        block.bind(self).call(bar) if block_given?
      end
    end
    
    def look_up_nav_bar(name)
      nav_bars[name] ||= NavBar.new(name)
    end
    
    def nav_bars
      @nav_bars ||= {}
    end
    
  end
  
end
