# Part of an example application showing the
# many features of Xebec.
class ProjectsController < ApplicationController

  # set the selected item for the :area navigation bar
  # for all actions in this controller:
  nav_bar(:area) { |nb| nb.current = :projects }

  def index
    params[:sort] ||= 'recent'
    # set up tabs for the project-list view:
    nav_bar(:tabs) do |nb|
      nb.nav_item :by_alpha, projects_path(:sort => 'by_alpha')
      nb.nav_item :recent,   projects_path(:sort => 'recent')
      nb.current = params[:sort]
    end
    @projects = Project.ordered_by(params[:sort])
  end

  def show(selected_tab = :overview)
    @project = Project.find(params[:id])
    prepare_project_tabs selected_tab
  end

  def budget
    show :budget
  end

  def history
    show :history
  end

  def edit
    show :edit
  end

  protected

  # Extract navigation bar setup that is common to
  # multiple methods:
  def prepare_project_tabs(selected)
     nav_bar(:tabs) do |nb|
      nb.nav_item :overview, project_path(@project)
      nb.nav_item :budget,   budget_project_path(@project)
      nb.nav_item :history,  history_project_path(@project)
      nb.nav_item :edit,     edit_project_path(@project)
      nb.current = selected
    end
  end

end
