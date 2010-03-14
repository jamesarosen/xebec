require File.join(File.dirname(__FILE__), 'test_helper')
require 'xebec'
require 'xebec/web_app_theme_renderer'

class WebAppThemeRendererTest < Test::Unit::TestCase
  
  def setup
    @bar = Xebec::NavBar.new('plants')
    @helper = new_nav_bar_helper
    @renderer = Xebec::renderer_class.new(@bar, @helper)
    @bar.nav_item :baz, '/baz'
  end
  
  context 'using the Web-App-Theme support' do
    should 'replace the default renderer class automatically' do
      assert_equal Xebec::WebAppThemeRenderer, Xebec::renderer_class
    end
    
    should 'render navigation <ul>s with wat-cf' do
      assert_select_from @renderer.to_s, 'ul.wat-cf'
    end
  end
  
end
