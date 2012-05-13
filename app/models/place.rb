class Place
  include MongoMapper::Document

  key :name

  key :street
  key :city
  key :country
  key :zip

  key :latitude
  key :longitude

  key :message
  key :network

  key :review_ids, Array
  many :reviews, :in => :review_ids

  timestamps!

end
