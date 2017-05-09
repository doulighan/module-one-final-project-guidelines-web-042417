require_relative '../lib/RedditApi.rb'

reddit = RedditApi.new 
posts = reddit.get_post_info
reddit.get_comments_of_post(posts[0])
binding.pry