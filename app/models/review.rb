class Review
  include MongoMapper::Document

  key :title, String
  key :body, String
  key :author, User
  timestamps!

  belongs_to :place

end
