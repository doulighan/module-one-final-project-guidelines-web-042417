require_relative '../lib/RedditApi.rb'

reddit = RedditApi.new 
reddit.get_post_titles
binding.pry