class Review
  include MongoMapper::Document

  key :title, String
  key :body, String
  key :author, User
  key :rating, Integer
  timestamps!

  belongs_to :place

end
