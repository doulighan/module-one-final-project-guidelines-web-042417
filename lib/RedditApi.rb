require 'rest-client'
require 'json'
require 'pry'

class RedditApi

  #data / body

  ALL_URL = "https://www.reddit.com/r/all/.json"

  def get_post_info
    posts = []
    api = JSON.parse(RestClient.get("https://www.reddit.com/.json"))
    api["data"]["children"].each do |post|
      posts << 
      {
      name: post["data"]["name"],
      title: post["data"]["title"],
      subreddit: post["data"]["subreddit"],
      author: post["data"]["author"],
      num_comments: post["data"]["num_comments"],
      score: post["data"]["score"],
      }
    end
    posts
  end



  def get_comments_of_post(post)
    comments = []
    api = JSON.parse(RestClient.get("https://www.reddit.com/r/#{post[:subreddit]}/comments/#{post[:id]}?sort=top/.json"))

    api["data"]["children"].each do |comment|
      comments << 
      {
        name: comment["data"]["name"],
        parent_name: comment["data"]["parent_id"],
        link_name: comment["data"]["link_id"],
        body: comment["data"]["body"],
        author: comment["data"]["author"],
        score: comment["data"]["score"]
      }
    end
    print_comments(comments)
    p comments.length
    comments
  end

  def print_comments(comments)
    count = 0
    comments.each do |c|
      p "score: #{c[:score]}"
      p "comment name: #{c[:name]}"
      p "parent id: #{c[:parent_name]}"
      count += 1
      p "#{c[:body]}"
    end
  end

  def top_comments(comments)
    comments.each do |c|
  end
end
end
