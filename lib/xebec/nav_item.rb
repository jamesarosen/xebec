module Xebec

  class NavItem

    attr_reader :name, :href, :html_options

    # Create a new navigation item.
    #
    # @param [String, Symbol] name the name of the item
    # @param [String, Hash, ActiveRecord::Base] href whither the navigation item links;
    #         defaults to the named route, "#{name}_path"
    # @param [Hash] html_options to be passed to the link_to helper method
    #
    # @see ActionView::Helpers::UrlHelper#url_for
    def initialize(name, href = nil, html_options = {})
      raise ArgumentError.new("#{name || '<nil>'} is not a valid name for a navigation item") if name.blank?
      @name, @href, @html_options = name, href, html_options
    end

  end

end
