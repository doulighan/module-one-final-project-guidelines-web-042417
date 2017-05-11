

class Post < ActiveRecord::Base

  has_many :comments,
  class_name: "Comment",
  foreign_key: :post_id

  belongs_to :subreddit,
  class_name: "Subreddit",
  foreign_key: :subreddit_id,
  primary_key: :subreddit_id

end
