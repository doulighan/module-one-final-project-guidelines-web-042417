
class RedditApi

 def self.get_hash_of_top_posts
    api = JSON.parse(RestClient.get("https://api.reddit.com/"))
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

  def self.find_comments_hash(post)
     JSON.parse(RestClient.get("https://api.reddit.com/r/#{post.subreddit}/comments/#{post.post_id[3..-1]}?sort=old.json")).last
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
  # def self.get_hash_of_comments(post)
  #
  #   api = JSON.parse(RestClient.get("https://api.reddit.com/r/#{post.subreddit}/comments/#{post.post_id[3..-1]}?sort=old.json")).last
  #   binding.pry
  #   api["data"]["children"].map do |comment|
  #     {
  #       comment_id: comment["data"]["name"],
  #       parent_id: comment["data"]["parent_id"],
  #       post_id: comment["data"]["link_id"],
  #       body: comment["data"]["body"],
  #       author: comment["data"]["author"],
  #       score: comment["data"]["score"].to_i
  #     }
  #   end
  # end

end

class Import
  def self.to_database
    post_objects = posts_to_database
    comments_to_database(post_objects)
  end

  private

  #returns posts as Post objects
  def self.posts_to_database
    posts = RedditApi.get_hash_of_top_posts
    posts.map do |post|
      if Post.find_by(post_id: post[:post_id]).nil?
        Post.create(post)
      else
        Post.find_by(post_id: post[:post_id])
      end
    end
  end

end
