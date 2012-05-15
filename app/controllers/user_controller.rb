class UserController < ApplicationController

  before_filter :require_user

  def index
  end

  def places
    @user = User.find(params[:id])
    @places = @user.places
    render :layout => false
  end

  protected

  def require_user
    if session['user_id'].blank?
      redirect_to root_path
    end
  end
end
