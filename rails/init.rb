require File.join(File.dirname(__FILE__), '..', 'init.rb')

# do any Rails-specific initialization here:

ActionController::Base.class_eval do

  # Add Xebec's view helper methods:
  helper Xebec::NavBarHelper

end
