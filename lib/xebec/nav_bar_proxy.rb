module Xebec
  
  class NavBarProxy
    
    # Create a new NavBar proxy object. The proxy will pass all
    # methods on to the NavBar except for +to_s+, which will 
    # render the NavBar as an HTML list.
    #
    # @param [Xebec::NavBar] bar the navigation bar to proxy
    # @param [#content_tag AND #link_to] helper the ActionView helper
    def initialize(bar, helper)
      raise ArgumentError.new("#{bar || '<nil>'} is not a NavBar") unless bar.kind_of?(NavBar)
      raise ArgumentError.new("#{helper || '<nil>'} does not seem to be a view helper") unless
        helper.respond_to?(:content_tag) && helper.respond_to?(:link_to_unless_current)
      @bar, @helper = bar, helper
    end
    
    # @return [String] the proxied navigation bar as an HTML list.
    def to_s
      if bar.empty?
        helper.tag(:ul, { :class => 'navbar' }, false)
      else
        helper.content_tag :ul, { :class => 'navbar' } do
          bar.items.map do |item|
            helper.content_tag :li do
              helper.content_tag :a, text_for(item), :href => url_for(item)
            end
          end
        end
      end
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
    
    def text_for(nav_item)
      nav_item.to_s.titleize
    end
    
    def url_for(nav_item)
      helper.send "#{nav_item}_path"
    end
    
  end
  
end
