require File.join(File.dirname(__FILE__), 'test_helper')
require 'xebec'
require 'xebec/html5'

class HTML5Test < Test::Unit::TestCase

  def setup
    @helper = new_nav_bar_helper
  end

  def internet_explorer_8
    'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; WOW64; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; MDDC)'
  end

  def internet_explorer_7
    'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; InfoPath.1; MS-RTC LM 8)'
  end

  def firefox
    'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.2pre) Gecko/20100225 Ubuntu/9.10 (karmic) Namoroka/3.6.2pre'
  end

  def safari
    'Mozilla/5.0 (iPod; U; CPU iPhone OS 2_2_1 like Mac OS X; en-us) AppleWebKit/525.18.1 (KHTML, like Gecko) Version/3.1.1 Mobile/5H11a Safari/525.20'
  end

  context 'HTML5#user_agent_supports_html5?' do
    setup { Xebec::HTML5.force = false }

    context 'when Xebec::HTML5.force is false' do
      should 'return false for Internet Explorer 8' do
        @helper.request.user_agent = internet_explorer_8
        assert !@helper.user_agent_supports_html5?
      end

      should 'return false for Internet Explorer 7' do
        @helper.request.user_agent = internet_explorer_7
        assert !@helper.user_agent_supports_html5?
      end

      should 'return true for Firefox' do
        @helper.request.user_agent = firefox
        assert @helper.user_agent_supports_html5?
      end

      should 'return true for Safari' do
        @helper.request.user_agent = safari
        assert @helper.user_agent_supports_html5?
      end
    end

    context 'when Xebec::HTML5.force is true' do
      setup { Xebec::HTML5.force = true }

      should 'return false for Internet Explorer 8' do
        @helper.request.user_agent = internet_explorer_8
        assert @helper.user_agent_supports_html5?
      end

      should 'return false for Internet Explorer 7' do
        @helper.request.user_agent = internet_explorer_7
        assert @helper.user_agent_supports_html5?
      end

      should 'return true for Firefox' do
        @helper.request.user_agent = firefox
        assert @helper.user_agent_supports_html5?
      end

      should 'return true for Safari' do
        @helper.request.user_agent = safari
        assert @helper.user_agent_supports_html5?
      end
    end

  end

end
