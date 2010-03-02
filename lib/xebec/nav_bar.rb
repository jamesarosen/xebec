module Xebec
  
  class NavBar
    
    attr_reader :name
    
    # Create a new NavBar object.
    #
    # @param [String] name the name of the navigation bar; defaults to :default
    def initialize(name = nil)
      @name = name || :default
    end
    
  end
  
end
