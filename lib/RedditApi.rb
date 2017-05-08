require 'rest-client'
require 'json'
require 'pry'

class RedditApi

  #data / body

  ALL_URL = "https://www.reddit.com/r/all/.json"

  def get_post_titles
    posts = []
    api = JSON.parse(RestClient.get("https://www.reddit.com/.json"))
    api["data"]["children"].each do |post|
      posts << 
      {
      id: post["data"]["id"],
      title: post["data"]["title"],
      subreddit: post["data"]["subreddit"],
      num_comments: post["data"]["num_comments"],
      upvotes: post["data"]["ups"]
      }
    end
    binding.pry
  end
end