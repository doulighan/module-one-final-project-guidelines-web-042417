
class RedditApi


 def self.get_hash_of_top_posts(redirect=nil)


    api = JSON.parse(RestClient.get("https://api.reddit.com/#{redirect}/.json?limit=10"))

    api["data"]["children"].map do |post|
    
      {
      post_id: post["data"]["name"],
      title: post["data"]["title"],
      subreddit_id: post["data"]["subreddit_id"],
      subreddit_title: post["data"]["subreddit"],
      author: post["data"]["author"],
      score: post["data"]["score"].to_i
      }
    end
  end



  def self.find_comments_hash(post)
    
   # r = "https://api.reddit.com/r#{post.subreddit}/comments/#{post.post_id[3..-1]}?sort=old.json"
    
     JSON.parse(RestClient.get("https://api.reddit.com/comments/#{post.post_id[3..-1]}?sort=old.json")).last
        
  end

  def self.get_hash_of_comments(hash)
    result = []
    # debugger
    return result unless hash.is_a?(Hash)
    parameters = Proc.new {|argument|
      {
        comment_id: argument["data"]["name"],
        parent_id: argument["data"]["parent_id"],
        post_id: argument["data"]["link_id"],
        body: argument["data"]["body"],
        author: argument["data"]["author"],
        score: argument["data"]["score"].to_i
      }
    }
    hash["data"]["children"].each do |comment|
      result.concat([parameters.call(comment)])

      result.concat(self.get_hash_of_comments(comment["data"]["replies"]))
    end
    result
  end
end
