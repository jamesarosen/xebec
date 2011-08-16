require File.join(File.dirname(__FILE__), 'test_helper')
require 'xebec'

class TitleEnhancedNavBarRendererTest < Test::Unit::TestCase

  def setup
    @old_renderer_class = Xebec::renderer_class
    load 'xebec/title_enhanced_nav_bar_renderer.rb'
    clear_translations!
    @bar = Xebec::NavBar.new('elements')
    @helper = new_nav_bar_helper
    @renderer = Xebec::renderer_class.new(@bar, @helper)
    @bar.nav_item :zn, '/elements/zn'
  end

  def teardown
    Xebec::renderer_class = @old_renderer_class
  end

  context 'using the title-enhanced renderer' do

    should 'replace the default renderer class automatically' do
      assert_equal Xebec::TitleEnhancedNavBarRenderer, Xebec::renderer_class
    end

    context 'with neither text nor a title translation specified' do
      should "use the nav item's name titleized for the link text" do
        assert_select_from @renderer.to_s, 'ul li.zn' do
          assert_select 'a', 'Zn'
        end
      end
      should "use the nav item's name titleized for the <li>'s title" do
        assert_select_from @renderer.to_s, 'ul li.zn[title="Zn"]'
      end
    end

    context 'with a text but not a title translation specified' do
      setup do
        define_translation 'navbar.elements.zn.text', 'Zinc'
        @bar.nav_item :zn, '/zn'
      end
      should "use the text translation for the link text" do
        assert_select_from @renderer.to_s, 'ul li.zn' do
          assert_select 'a', 'Zinc'
        end
      end
      should "use the text translation for the <li>'s title" do
        assert_select_from @renderer.to_s, 'ul li.zn[title="Zinc"]'
      end
    end

    context 'with a title but no text translation specified' do
      setup do
        define_translation 'navbar.elements.zn.title', 'Zinc'
        @bar.nav_item :zn, '/zn'
      end
      should "use the nav item's name titleized for the link text" do
        assert_select_from @renderer.to_s, 'ul li.zn' do
          assert_select 'a', 'Zn'
        end
      end
      should "use the title translation for the <li>'s title" do
        assert_select_from @renderer.to_s, 'ul li.zn[title="Zinc"]'
      end
    end

    context 'with both a title and a text translation specified' do
      setup do
        define_translation 'navbar.elements.zn.text',  'Zinc'
        define_translation 'navbar.elements.zn.title', '30: Zinc'
        @bar.nav_item :zn, '/zn'
      end
      should "use the text translation for the link text" do
        assert_select_from @renderer.to_s, 'ul li.zn' do
          assert_select 'a', 'Zinc'
        end
      end
      should "use the title translation for the <li>'s title" do
        assert_select_from @renderer.to_s, 'ul li.zn[title="30: Zinc"]'
      end
    end

  end

end
