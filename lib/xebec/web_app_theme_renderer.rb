require 'xebec/nav_bar_renderer'

module Xebec

  # Replaces the default Xebec::NavBarRenderer with a version
  # that includes the CSS classes used by WebAppThemes.
  #
  # @see Xebec::NavBarRenderer
  # @see http://github.com/pilu/web-app-theme
  class WebAppThemeRenderer < ::Xebec::NavBarRenderer

    protected

    def list_tag
      return :ul, :class => 'wat-cf'
    end

  end

end

Xebec::renderer_class = Xebec::WebAppThemeRenderer
