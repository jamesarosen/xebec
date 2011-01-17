require 'xebec/nav_bar_renderer'

module Xebec

  # Replaces the default Xebec::NavBarRenderer with a version
  # that supports separate "text" and "title" internationalization
  # options for each navigation item. Instead of
  # "navbar.#{bar.name}.#{item_name}" for the text, use
  # "navbar.#{bar.name}.#{item_name}.text". Additionally,
  # use "navbar.#{bar.name}.#{item_name}.title" for a separate
  # title. The title will default to the text if not specified.
  #
  # @see Xebec::NavBarRenderer
  class TitleEnhancedNavBarRenderer < ::Xebec::NavBarRenderer

    protected

    def list_item_tag(item, klass, text, href, is_current)
      return :li, :class => klass, :title => title_for_nav_item(item, text)
    end

    def text_for_nav_item(item)
      item_name = item.name
      I18n.t "navbar.#{bar.name}.#{item_name}.text",  :default => item_name.to_s.titleize
    end

    def title_for_nav_item(item, text)
      item_name = item.name
      I18n.t "navbar.#{bar.name}.#{item_name}.title", :default => text
    end

  end

end

Xebec::renderer_class = Xebec::TitleEnhancedNavBarRenderer
