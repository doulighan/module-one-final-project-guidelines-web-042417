class CLI

  def self.run
    puts "Welcome to CLI reddit"
    posts = RedditApi.get_hash_of_top_posts
    RedditApi.import_posts_to_db(posts)
  end

end



# a = CLIRunner.new
# a.run
