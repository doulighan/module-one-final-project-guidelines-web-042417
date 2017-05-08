class Post
  has_many :comments
  belongs_to :user

  attr_accessor :poster, :upvotes, :body, :title

end
