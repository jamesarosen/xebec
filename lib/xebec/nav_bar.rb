require 'xebec/nav_item'

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
    #
    # To customize the link text, set the internationalization key
    # <tt>navbar.{{nav bar name}}.{{nav item name}}</tt>.
    #
    # @see Xebec::NavBarHelper#nav_bar
    # @see Xebec::NavBarProxy#to_s
    def nav_item(name, href = nil)
      items << Xebec::NavItem.new(name, href)
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
