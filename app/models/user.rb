class User
  include MongoMapper::Document

  key :place_ids, Array
  many :places, :in => :place_ids, :class_name => 'Place'

  key :review_ids, Array
  many :reviews, :in => :review_ids

  one :facebook

  timestamps!

  def add_place(place)
    places << place
    save
  end

  def checkins(network)
    places.select { |place| place.network === network }
  end

  def clear_checkins(network)
    places.delete_if { |place| place.network === network }
    save
  end

end
