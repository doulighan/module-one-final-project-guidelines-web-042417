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



  def self.comments_to_database(post_objects, num_comments=25)
    comments = post_objects.map { |post| RedditApi.get_hash_of_comments(post) }
    comments.map do |comments_page|
      comments_page.map do |comment|
        if Comment.find_by(comment_id: comment[:comment_id]).nil?
          Comment.create(comment)
        else
          Comment.find_by(comment_id: comment[:comment_id])
        end
      end
    end
  end
end
