require 'xebec/nav_bar_renderer'

module Xebec

  class <<self

    # The CSS class that is added to navigation items that are
    # "active." Defaults to "current."
    attr_accessor :currently_selected_nav_item_class

    # The navigation bar renderer class. Defaults to
    # Xebec::NavBarRenderer
    #
    # @see Xebec::NavBarRenderer
    attr_accessor :renderer_class
    
    # Chooses the behavior of NavBarRenderers when dealing with
    # the current item.  By default, they are rendered in a span
    # tag; however, if this flag is set to true, they will be
    # rendered as links (as they would be if they weren't the
    # current item).  Even with this flag set, the current item
    # will still get the CSS class set by 
    # currently_selected_nav_item_class.
    #
    # This setting can be overridden on a per-navbar basis.
    #
    # @see Xebec::NavBar#current_is_link
    attr_accessor :current_is_link

  end
  self.currently_selected_nav_item_class = :current
  self.renderer_class = Xebec::NavBarRenderer

  autoload :NavBarHelper,         'xebec/nav_bar_helper'
  autoload :ControllerSupport,    'xebec/controller_support'
  autoload :StylesheetGenerator,  'xebec/stylesheet_generator'

end
