class PlaceController < ApplicationController

  before_filter :current_user

  def sync
    @graph = Koala::Facebook::API.new(session['access_token'])
    @checkins = @graph.get_connections('me', 'checkins')

    print current_user.inspect

    #loop thru each place
    @checkins.to_a.each do |checkin|
      @attr = parse_checkin(checkin, params['network'])
      current_user.add_place(Place.new(@attr))
    end
  end


  protected

  def current_user
    User.find(session['user_id']) 
  end

  def parse_checkin(checkin, network)
    @place = checkin['place']
    @location = @place['location']
    @place = {
      :name => @place['name'],
      :street => @location['street'],
      :city => @location['city'],
      :country => @location['country'],
      :zip => @location['zip'],
      :latitude => @location['latitude'],
      :longitude => @location['street'],
      :message => checkin['message'],
      :network => network
    }
  end

end
