
class RedditApi

  #ALL_URL = "https://api.reddit.com/.json"

 def self.get_hash_of_top_posts
    posts = []
    api = JSON.parse(RestClient.get("https://reddit.com/.json?limit=5"))
    api["data"]["children"].each do |post|
      posts <<
      {
      post_id: post["data"]["name"],
      title: post["data"]["title"],
      subreddit: post["data"]["subreddit"],
      author: post["data"]["author"],
      score: post["data"]["score"]
      }
    end
    posts
  end

  def self.get_hash_of_comments(post)
    comments = []
    api = JSON.parse(RestClient.get("https://api.reddit.com/r/#{post.subreddit}/comments/#{post.post_id[3..-1]}?sort=old.json"))
    api[0]["data"]["children"].each do |comment|
      comments <<
      {
        comment_id: comment["data"]["name"],
        parent_id: comment["data"]["parent_id"],
        post_id: comment["data"]["link_id"],
        body: comment["data"]["body"],
        author: comment["data"]["author"],
        score: comment["data"]["score"].to_i
      }
    end
    comments
  end

end


