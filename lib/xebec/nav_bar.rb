require 'xebec/nav_item'
require 'xebec/content_item'

module Xebec

  class NavBar

    DEFAULT_NAME = :default

    attr_reader :name
    attr_reader :items
    attr_reader :html_attributes
    attr_accessor :current

    # Create a new NavBar object.
    #
    # @param [String] name the name of the navigation bar; defaults to :default
    # @param [Hash] html_attributes additional HTML attributes for the
    #                               navigation bar, e.g. { :id => 'my-navbar' }
    def initialize(name = nil, html_attributes = nil)
      @name = name || DEFAULT_NAME
      @html_attributes = html_attributes || {}
      @items = []
      @current = nil
    end

    # Add a navigation item to this bar.
    #
    # @param [String, Symbol] name the name of the item
    # @param [String, Proc] href the URL of the item; optional
    # @param [Hash] html_options additional html_options to be passed to link_to
    #
    # To customize the link text, set the internationalization key
    # <tt>navbar.{{nav bar name}}.{{nav item name}}</tt>.
    #
    # @see Xebec::NavBarHelper#nav_bar
    # @see Xebec::NavBarProxy#to_s
    def nav_item(name, href = nil, html_options = {})
      items << Xebec::NavItem.new(name, href, html_options)
    end
    
    # Add a non-navigation content item to this bar.  This thinly wraps the content_tag helper method
    # from ActionView.
    #
    # The output of this item will be a <li> tag containing whatever tag you specify in the
    # arguments here.  You can give the generated <li> tag a class attribute by passing the
    # :list_item_class option in the options hash.
    #
    # @see Xebec::ContentItem.initialize
    # @see ActionView::Helpers::TagHelper#content_tag
    def content_item(name, content_or_options_with_block = nil, options = nil, escape = true, &block)
      items << Xebec::ContentItem.new(name, content_or_options_with_block, options, escape, &block)
    end

    def empty?
      items.empty?
    end

    def to_s
      "<NavBar #{name}>"
    end

    def inspect
      "<NavBar #{name}: #{items.map(&:name).join('|')}>"
    end

  end

end
