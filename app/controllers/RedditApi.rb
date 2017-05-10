
class RedditApi
 

 def self.get_hash_of_top_posts
    api = JSON.parse(RestClient.get("https://api.reddit.com/.json?limit=10"))
    api["data"]["children"].map do |post|
      {
      post_id: post["data"]["name"],
      title: post["data"]["title"],
      subreddit: post["data"]["subreddit"],
      author: post["data"]["author"],
      score: post["data"]["score"].to_i
      }
    end
  end

  def self.get_hash_of_comments(post)
    api = JSON.parse(RestClient.get("https://api.reddit.com/r/#{post.subreddit}/comments/#{post.post_id[3..-1]}?sort=old.json"))
    api.last["data"]["children"].map do |comment|
     
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

  def self.parsehelper(post)
    results = []
    json = JSON.parse(RestClient.get("https://api.reddit.com/r/#{post.subreddit}/comments/#{post.post_id[3..-1]}?sort=old.json")).last
    results = recursive_get_comments(json, results)

    results
  end


  def self.recursive_get_comments(json, results)
    
        data = json["data"]
        children = data["children"] || [{"data" => data, "kind" => json["kind"] }]
        
        children.each do |message|
         
          kind = message["kind"]
          if kind == "t1"
            results << 
            {
    
              comment_id: message["data"]["name"],
              parent_id: message["data"]["parent_id"],
              post_id: message["data"]["link_id"],
              body: message["data"]["body"],
              author: message["data"]["author"],
              score: message["data"]["score"].to_i
            }
            
            if message["data"]["replies"] != ""
              recursive_get_comments(message["data"]["replies"]["data"]["children"].flatten[0], results)
          end
        end
      end
    return results
  end











end