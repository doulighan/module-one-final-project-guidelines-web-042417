# # require 'require_all'
# require_relative 'RedditApi'
# # require_relative '../app/models/comment.rb'
# # require_relative '../app/models/post.rb'
# require_relative '../../config/environment.rb'

class CLI

  def self.run
    puts "Welcome to CLI reddit" 
#
    p Post.first
    RedditApi.get_comments_of_post(Post.first)

  end

end



# a = CLIRunner.new
# a.run



