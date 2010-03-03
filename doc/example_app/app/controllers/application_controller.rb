class ApplicationController < ActionController::Base
  
  # Add Xebec's view helper methods:
  helper Xebec::NavBarHelper
  
  # If you prefer to declare your navigation in your
  # controllers, start by including Xebec's controller support:
  include Xebec::ControllerSupport
  
  # then declare and populate some navigation bars:
  nav_bar :area do |nb|
    nb.nav_item :projects         # assumes projects_path
  end
  
  nav_bar :footer do |nb|
    nb.nav_item :about_us,        page_path(:about_us)
    nb.nav_item :faq,             page_path(:faq)
    nb.nav_item :feedback,        page_path(:feedback)
    nb.nav_item :privacy_policy,  page_path(:privacy_policy)
  end
  
end
