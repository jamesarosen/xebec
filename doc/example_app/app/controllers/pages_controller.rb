class PagesController < ApplicationController

  def show
    render :action => params[:page]
  end
  
end
