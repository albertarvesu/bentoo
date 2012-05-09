class Place
  include MongoMapper::Document

  key :name, String, :required => true

  key :location, String
  key :country, String, :required => true

  key :latitude, String
  key :longitude, String

  key :review_ids, Array
  many :reviews, :in => :review_ids

  timestamps!

end
