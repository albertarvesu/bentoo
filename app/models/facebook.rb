class Facebook
  include MongoMapper::EmbeddedDocument

  key :user_id, String, :required => true

  key :name, String, :required => true
  key :first_name, String
  key :middle_name, String
  key :last_name, String
  key :username, String, :required => true

  key :link, String
  key :gender, String

  key :timezone, String
  key :locale, String

  key :picture, String
  key :birthday, Date

  timestamps!

  embedded_in :user

end
