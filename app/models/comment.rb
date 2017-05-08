class Comment
  belongs_to :post
  has_many :comments,

  attr_accessor :user, :body
    class_name: "Comment",
    foreign_key: :parent_id
  # belongs_to :parent_comment




end

comment: post_id, id, parent_id

post = 2  id = 217, text = "omg this is so funny", parent_id = nil
post = 2  id 324, text = "your mom is funny", parent_id = 217
post = 2  id 342, text = "settle down", parent_id = 218
