class Comment
  belongs_to :post
  has_many :comments,

  attr_accessor :user, :body
    class_name: "Comment",
    foreign_key: :parent_id
  # belongs_to :parent_comment




end
