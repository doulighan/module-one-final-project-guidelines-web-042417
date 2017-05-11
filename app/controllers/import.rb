class Import
  def self.to_database
    post_objects = posts_to_database
    comments_to_database(post_objects)
  end

  #returns subreddit posts as objects
  def self.subreddit_to_database(comment)
    subreddit = Subreddit.find_or_create_by(subreddit_id: comment.post[:subreddit_id], title: comment.post[:subreddit_title])
    posts = posts_to_database("r/#{subreddit.title}")
  end

  private

  #returns posts as Post objects
  def self.posts_to_database(redirect=nil)
    posts = RedditApi.get_hash_of_top_posts(redirect)
    posts.map do |post|
      if Post.find_by(post_id: post[:post_id]).nil?
        Post.create(post)
      else
        Post.find_by(post_id: post[:post_id])
      end
    end
  end



  def self.comments_to_database(post_objects, num_comments=25)
    comments = post_objects.map { |post| RedditApi.find_comments_hash(post) }
    hashes = []
    comments.each do |comments_page|
      hashes << RedditApi.get_hash_of_comments(comments_page).flatten
    end
      comment_objects = hashes.flatten.map do |comment|
        debugger
        if Comment.find_by(comment_id: comment[:comment_id]).nil? && !comment[:author].nil?
          Comment.create(comment_id: comment[:comment_id], post_id: comment[:post_id], parent_id: comment[:parent_id], body: comment[:body], author: comment[:author], score: comment[:score])
        else
          Comment.find_by(comment_id: comment[:comment_id])
        end
      end
    comment_objects
  end
end
