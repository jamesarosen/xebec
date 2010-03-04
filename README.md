## Xebec ##

Xebec is a Gem and Rails plugin that helps you build navigation for your website.
Tired of building custom navigation code for each site?

Have you seen Ryan Heath's [Navigation Helper](http://github.com/rpheath/navigation_helper)? It's very usable, but it only does one navigation bar. I often have sites where there are many, e.g.

    +-----------------------------------------------------------+
    | MyApp                           | Home | Sign Out | FAQ | | # "site" nav bar
    |===========================================================|
    | | *Projects* | Friends |                                  | # "area" nav bar
    |===========================================================|
    | | Project Overview | *Budget* | History |                 | # "tabs" nav bar
    |                                                           |
    |                                                           |
    | Project "Foo" Budget                                      |
    | ====================                                      |
    | ...                                                       |
    +-----------------------------------------------------------+

Each navigation bar has dynamic content. The *site* one will often have a "Sign In" and "Sign Up" link when no user is signed-in, but will have a "Sign Out" link otherwise. The *area* bar will often change based on the permissions/roles of the person signed in. The *tabs* bar will certainly depend on the area and the permissions/roles, and possibly also the features of the item being viewed. (Do all projects have budgets? If the "Budget" link goes to "./budget" then it doesn't have to be generated for each project, but it might not be so easy in other cases.)

(Of course, these *site*, *area*, and *tabs* aren't the only possibilities, merely a common pattern.)

Another common pattern is to differentiate the currently-selected navigation item in each applicable bar. (The asterisks in the above display.) In the case above, it probably makes sense to leave the "Projects" *area* item as a link when browsing a specific project so the user may easily return to the projects listing page. On the other hand, the currently active *tabs* item probably doesn't need to be a link. Clicking that would be the equivalent of a refresh.

Thus, Xebec.

### Installing Xebec in a Rails Application ###

#### Add the Gem Dependency ####

If you're using Bundler, add this to your `Gemfile`:

    gem "xebec"
    
If not, add this to `config/environment.rb`:

    config.gem 'xebec'

#### Add the Helpers ####

Add this to your `ApplicationController`:

    class ApplicationController < ActionController::Base
      helper Xebec::NavBarHelper
    end

### Rendering a Navigation Bar ###

To render a navigation bar, render `nav_bar` in your view, passing the name of the bar:

    <%= nav_bar :site %>
    
If you want to render the navigation bar only if it contains any items, use `nav_bar_unless_empty`:

    <%= nav_bar_unless_empty :area >
    
If you only have one navigation bar on your site, you can leave off the name, like so:

    <%= nav_bar %>
    
Xebec will assign this navigation bar the name `:default` in case you need to refer to it elsewhere, but you probably won't.

### Populating a Navigation Bar ###

To add items to your navigation bar in a view, call `nav_bar` with a block containing any number of `nav_item` calls:

    <%
      nav_bar :site do |nb|
        nb.nav_item :home,     root_path
        nb.nav_item :sign_in   unless signed_in? # assumes sign_in_path
      end
    %>
    
### Highlighting the "Current" Element of a Navigation Bar ###

The `nav_bar` helper method will add the "current" class to the currently-selected item of each navigation bar. Highlighting the item requires just some basic CSS:

    ul.navbar { color: green; }
    ul.navbar li.current { color: purple; }
    
### Setting the "Current" Element of a Navigation Bar ###

A navigation bar will automatically set an item as selected if its URL matches the current page URL. That will work for pages like "FAQ" above, but what if you want "Projects" to be highlighted not only for the projects list page but also for any page in the "Projects" area, such as an individual project's "Budget" tab? You can manually set the *current* item in a navigation bar like so:

    <% nav_bar(:area).current = :projects %>

### Example Application ###

To see the full range of features that Xebec supports, including internationalization and `before_filter`s for your controllers, check out the example application in `doc/example_app/`.

## What's a *xebec*? ##

Apple's dictionary provides the following entry:

> **xe‧bec** |ˈzēˌbek| (also **ze‧bec**)
noun historical
a small three-masted Mediterranean sailing ship with lateen and sometimes square sails.
ORIGIN mid 18th cent.: alteration (influenced by Spanish ***xabeque***) of French ***chebec***, via Italian from Arabic ***šabbāk***.