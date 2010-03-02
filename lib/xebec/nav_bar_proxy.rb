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
      helper.tag(:ul, { :class => 'navbar' }, false)
    end
    
    protected
    
    attr_reader :bar, :helper
    
  end
  
end
