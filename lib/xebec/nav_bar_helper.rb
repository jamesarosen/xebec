require 'xebec/nav_bar'
require 'xebec/nav_bar_proxy'
require 'xebec/has_nav_bars'

module Xebec
  
  module NavBarHelper
    
    include Xebec::HasNavBars
    include Xebec::HTML5
    
    # If called in an output expression ("<%= navbar %>" in ERB
    # or "=navbar" in HAML), renders the navigation bar.
    #
    # @example
    #   <%= navbar :tabs %>
    #   # => <ul class="navbar tabs">...</ul>
    #
    # @see Xebec::NavBarProxy#to_s
    # 
    # If called with a block, yields the underlying NavBar for
    # modification.
    #
    # @example
    #   <% navbar do |nb|
    #     nb.nav_item :home
    #     nb.nav_item :faq, pages_path(:page => :faq)
    #   end %>
    #
    # @see Xebec::NavBar#nav_item
    # @see Xebec::HasNavBars#nav_bar
    #
    # @return [Xebec::NavBarProxy]
    def nav_bar(name = nil, html_attributes = {}, &block)
      look_up_nav_bar_and_eval name, html_attributes, &block
    end
    
    # Renders a navigation bar if and only if it contains any
    # navigation items. Unlike +nav_bar+, this method does not
    # accept a block.
    #
    # @return [String, Xebec::NavBarProxy]
    def nav_bar_unless_empty(name = nil, html_attributes = {})
      bar = look_up_nav_bar name, html_attributes
      bar.empty? ? '' : bar
    end
    
    # Renders a <tt>&lt;script></tt> tag that preloads HTML5
    # tags in IE. Useful if you called
    # <tt>Xebec.html5_for_all_browsers!</tt> in your
    # <tt>environment.rb</tt>.
    #
    # @see Xebec::HTML5
    def add_html5_dom_elements_to_ie
      return <<-EOS
<!--[if IE]>
  <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
EOS
    end
    
    protected
    
    # Override HasNavBars#look_up_nav_bar to replace with a
    # proxy if necessary.
    def look_up_nav_bar(name, html_attributes)
      bar = super(name, html_attributes)
      if bar.kind_of?(Xebec::NavBar)
        bar = nav_bars[bar.name] = NavBarProxy.new(bar, self)
      end
      bar
    end
    
  end
  
end
