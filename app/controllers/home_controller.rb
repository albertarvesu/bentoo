class HomeController < ApplicationController

  FACEBOOK_APP_ID = '412264092137162'
  FACEBOOK_APP_SECRET = 'fb62f109a097778043ae3419c3453a0b'
  FACEBOOK_SITE_URL = 'http://localhost:3000/'
  FACEBOOK_PERMISSIONS = 'publish_stream,user_status,friends_status,user_hometown,friends_hometown,user_location,friends_location'

  def index
    if session['access_token']
      @graph = Koala::Facebook::GraphAPI.new(session['access_token'])
      @profile = @graph.get_object('me')
      render "home"
    else
      render "index"
    end
  end

  def login
    session['oauth'] = Koala::Facebook::OAuth.new(FACEBOOK_APP_ID, FACEBOOK_APP_SECRET, FACEBOOK_SITE_URL + '/callback')
    redirect_to session['oauth'].url_for_oauth_code(:permissions => FACEBOOK_PERMISSIONS)
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
