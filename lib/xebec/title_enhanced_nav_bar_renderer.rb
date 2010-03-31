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
    
    def render_nav_item(item)
      text  = text_for_nav_item item
      title = title_for_nav_item item, text
      href  = href_for_nav_item item
      is_current = is_current_nav_item?(item, href)
      klass = item.name.to_s
      klass << " #{Xebec.currently_selected_nav_item_class}" if is_current
      helper.content_tag :li, :class => klass, :title => title do
        if is_current
          helper.content_tag :span, text
        else  
          helper.link_to text, href
        end
      end
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
