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

The Xebec-enabled site layout for the above site might look something like this:

    <body>
      <div id='header'>
        <h1>My Site</h1>
        <%= nav_bar :site %>
      </div>
      <%= nav_bar_unless_empty :area %>
      <div id='content'>
        <%= nav_bar_unless_empty :tabs %>
        <%= yield %>
      </div>
      <div id='footer>
        &copy; 2293 My Happy Company
        <%= nav_bar :footer %>
      </div>
    </body>
    
If you only have one navigation bar on your site, you can leave off the name, like so:

    <%= nav_bar %>
    
Xebec will assign this navigation bar the name `:default` in case you need to refer to it elsewhere, but you probably won't.

### Populating a Navigation Bar ###

To add items to your navigation bar in a view, call `nav_bar` with a block and without rendering:

    <%
      nav_bar :site do
        nav_item :home,     root_path
        nav_item :sign_in,  sign_in_path  unless signed_in?
        nav_item :sign_up,  sign_up_path  unless signed_in?
        nav_item :sign_out, sign_out_path if signed_in?
        nav_item :faq,      faq_path
      end
    %>
    
### Highlighting the "Current" Element of a Navigation Bar ###

The `nav_bar` helper method will add the name of the currently-selected navigation item to the `<ul>`'s class. Highlighting just takes a little CSS trickery:

    ul.navbar { color: green; }
    
    ul.navbar.home li.home, ul.navbar.sign_in li.sign_in,
    ul.navbar.sign_up li.sign_up, ul.navbar.sign_out li.sign_out,
    ul.navbar.faq li.faq {
      color: purple;
    }
    
### Setting the "Current" Element of a Navigation Bar ###

A navigation bar will automatically set an item as selected if its URL matches the current page URL. That will work for pages like "FAQ" above, but what if you want "Projects" to be highlighted not only for the projects list page but also for any page in the "Projects" area, such as an individual project's "Budget" tab? You can manually set the *current* item in a navigation bar like so:

    <% nav_bar(:area).current = :projects %>

### DRYing It All Up ###

Grab a towel, we're going to DRY things up a bit. The first step is to combine the declaration and rendering of the *site* navigation bar and move them into a partial. In `app/views/layouts/application.html.erb`:

    <body>
      <div id='header'>
        <h1>My Site</h1>
        <%= render :partial => '/layouts/site_nav_bar' %>
        ...

And in `app/views/layouts/_site_nav_bar.html.erb`:

    <%=
      nav_bar(:site) do
        nav_item :home, root_path
        ...
      end
    %>
    
The next problem is that we have `<% nav_bar(:area).current = :projects %>` in *every* view inside `app/views/projects`. Here, we will blur the lines a little bit between Controller and View for the sake of DRYness. In `app/controllers/projects_controller.rb`:

    class ProjectsController < ApplicationController
      include Xebec::ControllerSupport      # or push this up to ApplicationController
                                            # if other Controllers will need it
      append_before_filter lambda { nav_bar(:area).current = :projects }
    end
    
`Xebec::ControllerSupport` provides quite a bit more than just a way to DRY up setting the currently selected item in a navigation bar. If you want to blur the line between Controller and View even further, you can do any of the following:

#### Declare and Populate Navigation Bars ####

    class ApplicationController    
      # block style:
      nav_bar(:footer) do |nb|
        nb.nav_item :about_us
        nb.nav_item :faq
        nb.nav_item :feedback
        nb.nav_item :privacy_policy
      end
      
      # individual style:
      nav_item_for :header, :home
    end

This syntax assumes that there is a named route for each of the navigation items. Want to use a named route other than the one generated from the `item_name`? Pass a `Proc` that, when called, generates a path:

        class ApplicationController
          nav_item_for :site, :faq,
                       :link => lambda { |controller| controller.page_path('faq') }
        end

Or, if the link is to a static URL (e.g. an external site), pass a `String`:

    class ApplicationController
      nav_item_for :site, :blog, :link => 'http://blog.example.org'
    end

#### Add Conditions to Navigation Items ####

    class ApplicationController
      nav_item_for :site, :sign_in,  :unless => :signed_in?
      nav_item_for :site, :sign_out, :if => :signed_in?
      nav_item_for :area, :admin,
                   :if => lambda { |controller| controller.current_user.admin? }
    end
    
#### Add Navigation Bars or Items Only for Certain Actions ####

    class ProjectsController
      nav_bar(:tabs, :only => [:show, :budget, :history, :edit]) do |nb|
        ...
      end
    end

### Controller Instance Methods ###

All of the *class* versions above are just `before_filter`s that wrap instance methods, so they're all available within an action.

    class ProjectsController
      nav_bar(:area) do
        self.selected = :projects
      end
      
      def index
        nav_bar(:tabs) do |nb|
          nb.nav_item :by_alpha, :text => 'A-Z',
                                 :link => projects_path(:tab => 'by_alpha')
          nb.nav_item :recent, :text => 'Recently Updated',
                               :link => projects_path(:tab => 'recent')
          nb.selected = params[:tab] || :by_alpha
        end
      end

      def show
        @project = Project.find(params[:id])
        prepare_project_tabs :overview
      end

      def budget
        @project = Project.find(params[:id])
        prepare_project_tabs :budget
      end

      def history
        @project = Project.find(params[:id])
        prepare_project_tabs :history
      end

      protected
      def prepare_project_tabs(selected)
         nav_bar(:tabs) do |nb|
          nb.nav_item :overview, :link => project_path(@project)
          nb.nav_item :budget,   :link => budget_project_path(@project)
          nb.nav_item :history,  :link => history_project_path(@project)
          nb.selected = selected
        end
      end

    end

## What's a *xebec*? ##

Apple's dictionary provides the following entry:

> **xe‧bec** |ˈzēˌbek| (also **ze‧bec**)
noun historical
a small three-masted Mediterranean sailing ship with lateen and sometimes square sails.
ORIGIN mid 18th cent.: alteration (influenced by Spanish ***xabeque***) of French ***chebec***, via Italian from Arabic ***šabbāk***.