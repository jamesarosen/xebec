module Xebec
  
  class <<self
    
    # The CSS class that is added to navigation items that are
    # "active." Defaults to "current."
    attr_accessor :currently_selected_nav_item_class
    
  end
  self.currently_selected_nav_item_class = :current
  
  autoload :NavBarHelper,         'xebec/nav_bar_helper'
  autoload :ControllerSupport,    'xebec/controller_support'
  autoload :StylesheetGenerator,  'xebec/stylesheet_generator'
  
end
