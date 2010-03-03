module Xebec
  
  class NavItem
    
    attr_reader :name, :href
    
    def initialize(name, href = nil)
      raise ArgumentError.new("#{name || '<nil>'} is not a valid name for a navigation item") if name.blank?
      @name, @href = name, href
    end
    
  end
  
end
