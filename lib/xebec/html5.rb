module Xebec

  def self.html5_for_all_browsers!
    Xebec::HTML5.force = true
  end

  # Xebec will help you transition your site to HTML 5
  # by using the <tt>&lt;nav></tt> element like so:
  #
  #   <nav class='my_navbar_name'>
  #     <ul>
  #       <li><a href='/home'>Home</a></li>
  #       ...
  #     </ul>
  #   </nav>
  #
  # Most browsers are perfectly happy with the <tt>&lt;nav></tt>
  # element, but Internet Explorer (all current versions)
  # behaves... *oddly*. Specifically, IE will treat the
  # above HTML as though it were really this:
  #
  #   <nav class='my_navbar_name'>
  #   </nav>
  #   <ul>
  #     <li><a href='/home'>Home</a></li>
  #     ...
  #   </ul>
  #
  # That, unfortunately messes with your CSS selectors. Xebec,
  # therefore, has a slightly more intelligent default behavior.
  # If it detects a browser that does not support HTML5 elements,
  # it will replace the <tt>&lt;nav></tt> element with a
  # <tt>&lt;div class='navbar'></tt>.
  #
  # Some enterprising folks have found a workaround for IE, however.
  # If you *really* want to use the <tt>&lt;nav></tt> element for
  # all browsers, do two things:
  #
  # 1. in config/environment.rb, call <tt>Xebec.html5_for_all_browsers!</tt>
  #
  # 2. in the <tt>&lt;head></tt> tag in your site layout,
  #    call <tt>&lt;%= add_html5_dom_elements_to_ie %></tt>
  #
  # @see Xebec.html5_for_all_browsers!
  # @see Xebec::NavBarHelper.add_html5_dom_elements_to_ie
  # See also the example application.
  module HTML5

    class <<self
      attr_accessor :force
    end
    self.force = false

    NON_HTML_5_USER_AGENTS = /msie/i

    def user_agent_supports_html5?
      return true if Xebec::HTML5.force
      return !(NON_HTML_5_USER_AGENTS === request.user_agent)
    end

  end

end
