<<<<<<< HEAD
class Post
  has_many :comments

  attr_accessor :poster, :upvotes, :body, :title
=======
class Post < ActiveRecord::Base
  has_many :comments,
  class_name: "Comment",
  foreign_key: :post_id
  
  belongs_to :user
>>>>>>> models

end
