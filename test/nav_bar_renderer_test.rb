require File.join(File.dirname(__FILE__), 'test_helper')
require 'xebec'

class NavBarRendererTest < Test::Unit::TestCase
  
  context 'creating a NavBar renderer' do
    should 'require a NavBar' do
      assert_raises(ArgumentError) do
        Xebec::NavBarRenderer.new('foobar', new_nav_bar_helper)
      end
    end
    should 'require a NavBarHelper' do
      assert_raises(ArgumentError) do
        Xebec::NavBarRenderer.new(Xebec::NavBar.new, 'baz')
      end
    end
  end
  
  context 'a NavBar renderer' do
    
    setup do
      clear_translations!
      @bar = Xebec::NavBar.new('elephants')
      @helper = new_nav_bar_helper
      @renderer = Xebec::NavBarRenderer.new(@bar, @helper)
    end
    
    should 'respond to :name' do
      assert @renderer.respond_to?(:name)
    end
    
    should "return the NavBar's name when sent :name" do
      assert_equal 'elephants', @renderer.name
    end
    
    should 'support additional HTML properties' do
      @bar.html_attributes.merge!(:id => 'salads-nav')
      assert_equal({:id => 'salads-nav'}, @renderer.html_attributes)
      assert_select_from @renderer.to_s, '#salads-nav'
    end
    
    should 'not respond to a method that the underlying NavBar does not' do
      assert !@renderer.respond_to?(:cromulize)
    end
    
    context 'for a browser that supports HTML5' do
      setup { @renderer.stubs(:user_agent_supports_html5?).returns(true) }
      
      should "render a navigation bar with the bar's name" do
        assert_select_from @renderer.to_s, "nav.elephants"
      end
      
      context 'with an empty NavBar' do
        should 'render an empty navigation bar' do
          assert_select_from @renderer.to_s, 'nav', /$^/
        end
      end
    end
    
    context 'for a browser that does not support HTML5' do
      setup { @helper.stubs(:user_agent_supports_html5?).returns(false) }
      
      should "render a div.navbar the bar's name" do
        assert_select_from @renderer.to_s, "div.navbar.elephants"
      end
      
      context 'with an empty NavBar' do
        should 'render an empty navigation bar' do
          assert_select_from @renderer.to_s, 'div.navbar', /$^/
        end
      end
    end
    
    context 'with a NavBar that has a navigation item declared as a name' do
      setup do
        @helper.stubs(:foo_path).returns("/foo")
        @bar.nav_item :foo
      end
      should 'render a navigation bar with the appropriate items' do
        assert_select_from @renderer.to_s, 'ul' do
          assert_select 'li' do
            assert_select 'a[href="/foo"]', 'Foo'
          end
        end
      end
    end
    
    context 'with a NavBar that has a navigation item set as current' do
      setup do
        @bar.nav_item :foo, '/foo'
        @bar.current = :foo
      end
      should 'render a navigation bar with the item marked as current' do
        assert_select_from @renderer.to_s, 'ul' do
          assert_select 'li.current', 'Foo'
        end
      end
      context 'when Xebec is configured to use a different "current" class' do
        setup do
          @old_class = Xebec.currently_selected_nav_item_class
          Xebec.currently_selected_nav_item_class = 'active'
        end
        should 'use the configured CSS class' do
          assert_select_from @renderer.to_s, 'ul' do
            assert_select 'li.active', 'Foo'
          end
        end
        teardown do
          Xebec.currently_selected_nav_item_class = @old_class
        end
      end
    end
    
    context 'with a NavBar that has a navigation item not set as current' do
      setup do
        @bar.nav_item :foo, '/foo'
        @bar.current = :baz
      end
      should 'render a navigation bar with the item not marked as current' do
        assert_select_from @renderer.to_s, 'ul' do
          assert_select 'li', 'Foo'
          assert_select 'li.current', { :count => 0, :text=> 'Foo' }
        end
      end
      should 'not render an empty "class" attribute' do
        assert(!(/class\s*=\s*["']\s*["']/ === @renderer.to_s))
      end
    end
    
    context 'with a NavBar that has a navigation item declared as a name and URL' do
      setup do
        @bar.nav_item :foo, 'http://foo.com'
      end
      should 'render a navigation bar with the appropriate items' do
        assert_select_from @renderer.to_s, 'ul' do
          assert_select 'li' do
            assert_select 'a[href="http://foo.com"]', 'Foo'
          end
        end
      end
    end
    
    context 'with a NavBar that has a navigation item that links to the current page' do
      setup do
        @helper.stubs(:current_page?).with('/').returns(true)
        @bar.nav_item :home, '/'
        @bar.nav_item :sign_up, '/sign_up'
      end
      should 'render a non-link navigation item' do
        assert_select_from @renderer.to_s, 'ul' do
          assert_select 'li', 'Home' do
            assert_select 'a', 0
          end
        end
      end
      should 'render other items as links' do
        assert_select_from @renderer.to_s, 'ul' do
          assert_select 'li' do
            assert_select 'a[href="/sign_up"]', 'Sign Up'
          end
        end
      end
      should 'add the "current" class to the current item' do
        assert_select_from @renderer.to_s, 'ul' do
          assert_select 'li.current', 'Home'
        end
      end
    end
    
    context "with a NavBar that has a navigation item with an i18n'd title" do
      setup do
        define_translation 'navbar.elephants.foo', 'My Foos'
        @helper.stubs(:foo_path).returns("/foo")
        @bar.nav_item :foo
      end
      should 'render a navigation bar using the internationalized text' do
        assert_select_from @renderer.to_s, 'ul' do
          assert_select 'li' do
            assert_select 'a', 'My Foos'
          end
        end
      end
    end
    
  end
  
end
