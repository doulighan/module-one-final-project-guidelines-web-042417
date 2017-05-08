class Post
  has_many :comments

  attr_accessor :poster, :upvotes, :body, :title

end
