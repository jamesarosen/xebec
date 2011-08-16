# Part of an example application showing the
# many features of Xebec.
class PagesController < ApplicationController

  def show
    render :action => params[:page]
  end

end
