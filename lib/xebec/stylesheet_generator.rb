module Xebec
  
  # The `nav_bar` helper method will add the "current" class to the
  # currently-selected item of each navigation bar. Highlighting the
  # item requires just some basic CSS:
  # 
  # nav { color: green; }
  # nav .current { color: purple; }
  # 
  # Each rendered navigation bar will include its name as a CSS class
  # if you want to style them differently:
  # 
  # nav.site { color: green; }
  # nav.area { color: white; background-color: green; }
  # 
  # (In case you were wondering about those `nav` elements, they're
  # part of [the HTML5 specification](http://dev.w3.org/html5/spec/Overview.html#the-nav-element).
  #
  # @see Xebec::HTML5
  class StylesheetGenerator < Rails::Generator::Base

    def manifest
      record do |m|
        m.directory File.join('public', 'stylesheets')
        m.template 'xebec.css.erb', File.join('public', 'stylesheets', 'xebec.css')
      end
    end

    protected
    
    def after_generate
      puts "Generated a stylesheet with navigation bars #{navigation_bars.to_sentence}"
    end

    def navigation_bars
      args
    end

    def banner
      %{Usage: #{$0} #{spec.name} [nav_bar_name [nav_bar_name ...]]\nGenerates navigation bar stylesheets in public/stylesheets/}
    end
    
  end
  
end
