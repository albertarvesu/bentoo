class UserController < ApplicationController

  def index
  end

  def places
    @user = User.find(params[:id])
    @places = @user.places
    render :layout => false
  end
end
