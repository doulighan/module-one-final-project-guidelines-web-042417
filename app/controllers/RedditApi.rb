
class RedditApi


  def self.get_hash_of_top_posts(redirect=nil)
    api = JSON.parse(RestClient.get("https://api.reddit.com/#{redirect}/.json?limit=10"))
    api["data"]["children"].map {|post| post_hash_to_object(post )}
  end


  def self.find_comments_hash(post)
     JSON.parse(RestClient.get("https://api.reddit.com/comments/#{post.post_id[3..-1]}")).last
  end


  def self.get_hash_of_comments(hash)
    result = []
    return result unless hash.is_a?(Hash)
    hash["data"]["children"].each do |comment|
      result.concat(comment_hash_to_object(comment))
      result.concat(self.get_hash_of_comments(comment["data"]["replies"]))
    end

    result
  end

  def self.post_hash_to_object(hash)
    {
      post_id: post["data"]["name"],
      title: post["data"]["title"],
      subreddit_id: post["data"]["subreddit_id"],
      subreddit_title: post["data"]["subreddit"],
      author: post["data"]["author"],
      score: post["data"]["score"].to_i
    }
  end

    def self.comment_hash_to_object(hash)
      [{
        comment_id: hash["data"]["name"],
        parent_id: hash["data"]["parent_id"],
        post_id: hash["data"]["link_id"],
        body: hash["data"]["body"],
        author: hash["data"]["author"],
        score: hash["data"]["score"].to_i
        }]
    end
end
