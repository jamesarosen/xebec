module Xebec

  class ContentItem
    
    attr_reader :name, :klass, :content_tag_args, :block
    
    # Create a new non-navigation item in the list using Rails' content_tag helper.  We also allow an
    # additional special option, :list_item_class, that is not passed to content_tag.  If specified, it
    # will give a class to this item's <li> tag in the navigation bar.
    #
    # Note that the block is bound to the context in which the navigation bar is defined.  That means,
    # for example, that if you want to use helper functions such as link_to inside a ContentItem, you
    # must define the navigation bar inside a view or a helper method.
    #
    # @param [String, Symbol] name the HTML tag name to generate
    # @param [String, Hash] content_or_options_with_block the text inside the tag, or options if block is given
    # @param [Hash] options HTML options to pass to content_tag, and optionally :list_item_class
    # @param [Boolean] escape should content_tag escape attribute values?
    # @param [Proc] block optionally, a block to use for generating the content inside the tag.
    #
    # @see ActionView::Helpers::TagHelper#content_tag
    def initialize(name, content_or_options_with_block = nil, options = nil, escape = true, &block)
      real_options = block ? content_or_options_with_block : options
      @klass = real_options.try(:delete, :list_item_class)
      
      @name, @block = name, block
      @content_tag_args = [name, content_or_options_with_block, options, escape]
    end

  end
  
end