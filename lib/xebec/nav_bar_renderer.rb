require 'xebec/nav_bar'
require 'xebec/html5'

module Xebec

  # A renderer for a Xebec::NavBar that knows how to turn the NavBar
  # into an HTML list using ActionView helper methods.
  class NavBarRenderer

    # Create a new NavBar renderer object. The renderer will pass all
    # methods on to the NavBar except for +to_s+, which will
    # render the NavBar as an HTML list.
    #
    # @param [Xebec::NavBar] bar the navigation bar to renderer
    # @param [#tag AND #content_tag AND #link_to AND #current_page?] helper the ActionView helper
    def initialize(bar, helper)
      raise ArgumentError.new("#{bar || '<nil>'} is not a NavBar") unless bar.kind_of?(NavBar)
      raise ArgumentError.new("#{helper || '<nil>'} does not seem to be a view helper") unless
        helper.respond_to?(:content_tag) && helper.respond_to?(:link_to_unless_current)
      @bar, @helper = bar, helper
    end

    # @return [String] the proxied navigation bar as an HTML list.
    #
    # The HREF for each navigation item is generated as follows:
    #
    # * if the item was declared with a link
    #   (e.g. <tt>nav_item :faq, page_path(:page => :faq)</tt>),
    #   use that link
    # * else, try to use the route named after the navigation item
    #   (e.g. <tt>nav_item :home</tt> uses <tt>home_path</tt>)
    #
    # The link text for each navigation is generated as follows:
    #
    # * if the internationalization key
    #   <tt>navbar.{{nav bar name}}.{{nav item name}}</tt> is
    #   defined, use that value
    # * else, use <tt>nav_item.name.titleize</tt>
    def to_s
      root_element, options = *root_navbar_tag
      if bar.empty?
        helper.tag(root_element, options, false)
      else
        helper.content_tag(root_element, options) do
          helper.content_tag(*list_tag) do
            bar.items.map do |item|
              render_nav_item item
            end.join("")
          end
        end
      end
    end

    def inspect
      to_s
    end

    def respond_to?(sym)
      return true if bar.respond_to?(sym)
      super
    end

    def method_missing(sym, *args, &block)
      return bar.send(sym, *args, &block) if bar.respond_to?(sym)
      super
    end

    protected

    attr_reader :bar, :helper

    def root_navbar_tag
      html_attributes = bar.html_attributes
      html_attributes[:class] ||= ''
      (html_attributes[:class] << " #{bar.name}").strip!
      if helper.user_agent_supports_html5?
        return :nav, html_attributes
      else
        html_attributes[:class] << " navbar"
        return :div, html_attributes
      end
    end

    # @return the first two arguments to a <tt>content_tag</tt> call --
    #         the name and HTML properties of the tag
    def list_tag
      return :ul, {}
    end

    def render_nav_item(item)
      text = text_for_nav_item item
      href = href_for_nav_item item
      is_current = is_current_nav_item?(item, href)
      klass = '' << item.name.to_s
      klass << " #{Xebec.currently_selected_nav_item_class}" if is_current
      helper.content_tag(*list_item_tag(item, klass, text, href, is_current)) do
        if is_current
          helper.content_tag :span, text
        else
          helper.link_to text, href
        end
      end
    end

    # @param [Xebec::NavItem] item the navigation item
    # @param [String] klass the HTML class attribute generated (including
    #                       the "current" class if applicable)
    # @param [String] text
    # @param [String] href
    # @param [true, false] is_current
    # @return the first two arguments to a <tt>content_tag</tt> call --
    #         the name and HTML properties of the tag
    def list_item_tag(item, klass, text, href, is_current)
      return :li, :class => klass
    end

    def text_for_nav_item(item)
      item_name = item.name
      I18n.t "navbar.#{bar.name}.#{item_name}", :default => item_name.to_s.titleize
    end

    def href_for_nav_item(item)
      item.href or helper.send("#{item.name}_path")
    end

    def is_current_nav_item?(item, href)
      current = bar.current.to_s
      current == item.name.to_s || current.blank? && helper.current_page?(href)
    end

  end

end
