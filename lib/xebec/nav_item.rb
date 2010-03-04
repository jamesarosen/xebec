module Xebec
  
  class NavItem
    
    attr_reader :name, :href
    
    # Create a new navigation item.
    #
    # @param [String, Symbol] name the name of the item
    # @param [String, Hash, ActiveRecord::Base] href whither the navigation item links;
    #         defaults to the named route, "#{name}_path"
    #
    # @see ActionView::Helpers::UrlHelper#url_for
    def initialize(name, href = nil)
      raise ArgumentError.new("#{name || '<nil>'} is not a valid name for a navigation item") if name.blank?
      @name, @href = name, href
    end
    
  end
  
end
