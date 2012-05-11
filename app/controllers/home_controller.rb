class HomeController < ApplicationController

  def index
    if session['access_token']
      @graph = Koala::Facebook::API.new(session['access_token'])
      @profile = @graph.get_object('me')
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
    redirect_to '/'
  end

end
