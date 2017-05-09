# require 'require_all'
require_relative 'RedditApi'
# require_relative '../app/models/comment.rb'
# require_relative '../app/models/post.rb'
require_relative '../../config/environment.rb'



  def run
    puts "Welcome to CLI reddit"    
    posts = RedditApi.get_hash_of_top_posts
    binding.pry
    RedditApi.import_posts_to_db(posts)
  end


run

# a = CLIRunner.new
# a.run



