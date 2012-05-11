class User
  include MongoMapper::Document

  key :place_ids, Array
  many :places, :in => :place_ids

  key :review_ids, Array
  many :reviews, :in => :review_ids

  one :facebook

  timestamps!

end
