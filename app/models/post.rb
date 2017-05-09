class Post < ActiveRecord::Base
  has_many :comments,
  class_name: "Comment",
  foreign_key: :post_id
  
  belongs_to :user

end
