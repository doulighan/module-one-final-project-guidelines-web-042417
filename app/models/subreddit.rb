class Subreddit < ActiveRecord::Base 

  # has_many :posts,
  #   foreign_key: :subreddit_id,
  #   primary_key: :subreddit_id

  #   has_many :comments,
  #     through: :posts,
  #     source: :comments
end