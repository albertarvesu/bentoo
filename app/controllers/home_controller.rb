class HomeController < ApplicationController

  before_filter :current_user

  def index
    if session['access_token']
      @graph = Koala::Facebook::API.new(session['access_token'])
      @facebook = current_user.facebook
      render "home"
    else
      render "index"
    end
  end

  def login
    session['oauth'] = Koala::Facebook::OAuth.new(FB_APP_ID, FB_APP_SECRET, FB_SITE_URL + '/callback')
    redirect_to session['oauth'].url_for_oauth_code(:permissions => FB_PERMISSIONS)
  end

  def logout
    session['oauth'] = nil
    session['access_token'] = nil
    session['user_id'] = nil
    redirect_to root_path
  end

  def callback

    session['access_token'] = session['oauth'].get_access_token(params[:code])
    @graph = Koala::Facebook::API.new(session['access_token'])
    @me = @graph.get_object("me")

    #check if facebook record exist for this user
    @user = User.where("facebook._id" => @me['id']).first
    if @user.nil?
      @user = User.new
      @user.facebook = Facebook.new(@me)
      @user.save
    end
    session['user_id'] = @user['_id']
    redirect_to root_path
  end

  def about
  end

  def contact
  end





  protected

  def current_user
    User.find(session['user_id']) 
  end

end
