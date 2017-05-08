class Comment
  belongs_to :user
  belongs_to :post
  has_many :comments
    class_name: "Comment",
    foreign_key: :parent_id
  # belongs_to :parent_comment




end
