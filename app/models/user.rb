class User
  include MongoMapper::Document

  key :username, :required => true

  key :place_ids, Array
  many :places, :in => :place_ids

  one :facebook

  timestamps!

end
