
class RedditApi

 def self.get_hash_of_top_posts
    api = JSON.parse(RestClient.get("https://api.reddit.com/.json?limit=5"))
    api["data"]["children"].map do |post|
      {
      post_id: post["data"]["name"],
      title: post["data"]["title"],
      subreddit: post["data"]["subreddit"],
      author: post["data"]["author"],
      score: post["data"]["score"]
      }
    end
  end

  def self.get_hash_of_comments(post)
    api = JSON.parse(RestClient.get("https://api.reddit.com/r/#{post.subreddit}/comments/#{post.post_id[3..-1]}?sort=old.json"))
    api[0]["data"]["children"].map do |comment|
      {
        comment_id: comment["data"]["name"],
        parent_id: comment["data"]["parent_id"],
        post_id: comment["data"]["link_id"],
        body: comment["data"]["body"],
        author: comment["data"]["author"],
        score: comment["data"]["score"].to_i
      }
    end
  end
end


