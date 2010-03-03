require File.join(File.dirname(__FILE__), 'test_helper')
require 'xebec'

class NavBarProxyTest < Test::Unit::TestCase
  
  context 'creating a NavBar proxy' do
    should 'require a NavBar' do
      assert_raises(ArgumentError) do
        Xebec::NavBarProxy.new('foobar', new_nav_bar_helper)
      end
    end
    should 'require a NavBarHelper' do
      assert_raises(ArgumentError) do
        Xebec::NavBarProxy.new(Xebec::NavBar.new, 'baz')
      end
    end
  end
  
  context 'a NavBar proxy' do
    
    setup do
      clear_translations!
      @bar = Xebec::NavBar.new('elephants')
      @helper = new_nav_bar_helper
      @proxy = Xebec::NavBarProxy.new(@bar, @helper)
    end
    
    should 'respond to :name' do
      assert @proxy.respond_to?(:name)
    end
    
    should "return the NavBar's name when sent :name" do
      assert_equal 'elephants', @proxy.name
    end
    
    should 'not respond to a method that the underlying NavBar does not' do
      assert !@proxy.respond_to?(:cromulize)
    end
    
    context 'with an empty NavBar' do
    
      should 'render an empty navigation bar' do
        assert_equal '<ul class="navbar" />', @proxy.to_s
      end
      
    end
    
    context 'with a NavBar that has a navigation item declared as a name' do
      setup do
        @helper.stubs(:foo_path).returns("/foo")
        @bar.nav_item :foo
      end
      should 'render a navigation bar with the appropriate items' do
        assert_select_from @proxy.to_s, 'ul.navbar' do
          assert_select 'li' do
            assert_select 'a[href="/foo"]', 'Foo'
          end
        end
      end
    end
    
    context 'with a NavBar that has a navigation item declared as a name and URL' do
      setup do
        @bar.nav_item :foo, 'http://foo.com'
      end
      should 'render a navigation bar with the appropriate items' do
        assert_select_from @proxy.to_s, 'ul.navbar' do
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
        assert_select_from @proxy.to_s, 'ul.navbar' do
          assert_select 'li', 'Home' do
            assert_select 'a', 0
          end
          assert_select 'li' do
            assert_select 'a[href="/sign_up"]', 'Sign Up'
          end
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
        assert_select_from @proxy.to_s, 'ul.navbar' do
          assert_select 'li' do
            assert_select 'a', 'My Foos'
          end
        end
      end
    end
    
  end
  
end
