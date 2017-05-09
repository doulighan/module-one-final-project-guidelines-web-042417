
class RedditApi

  #ALL_URL = "https://api.reddit.com/.json"

 def self.get_hash_of_top_posts
    posts = []
    api = JSON.parse(RestClient.get("https://reddit.com/.json"))
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

  def self.import_posts_to_db(posts)
    posts.map do |post|
      Post.create(post)
    end
  end















  def self.get_comments_of_post(post)
    comments = []
    api = JSON.parse(RestClient.get("https://api.reddit.com/r/#{post.subreddit}/comments/#{post.post_id[3..1]}?sort=top/.json"))

    api["data"]["children"].each do |comment|
      comments <<
      {
        comment_id: comment["data"]["name"],
        parent_id: comment["data"]["parent_id"],
        post_id: comment["data"]["link_id"],
        body: comment["data"]["body"],
        author: comment["data"]["author"],
        score: comment["data"]["score"]
      }
    end
    comments
  end

  def self.import_comments_to_db(comments)
    comments.map {|comment| Comment.create(comment)}
  end

  def self.print_comments(comments)
    count = 0
    comments.each do |c|
      p "score: #{c[:score]}"
      p "comment name: #{c[:name]}"
      p "parent id: #{c[:parent_id]}"
      count += 1
      p "#{c[:body]}"
    end
  end

  def self.top_comments(comments)
      comments.each do |c|
    end
  end
end
