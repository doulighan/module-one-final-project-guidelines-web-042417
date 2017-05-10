class Import

  def self.to_database
    
    posts = RedditApi.get_hash_of_top_posts
    post_objects = RedditApi.import_posts_to_db(posts)

    comments =  post_objects.map { |post| RedditApi.get_comments_of_post(post)}
    comments.map { |comment_page| RedditApi.import_comments_to_db(comment_page) }
  

  
  end



end