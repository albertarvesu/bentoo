class HomeController < ApplicationController

  def index
    if session['access_token']
      @graph = Koala::Facebook::API.new(session['access_token'])
      @facebook = session['current_user'].facebook
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
    redirect_to '/'
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

    session['current_user'] = @user
    redirect_to '/'

  end

end
