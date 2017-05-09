class CLI

  def self.run
    puts "Welcome to CLI reddit"
    puts "Here's what's trending right now"

    # posts = RedditApi.get_hash_of_top_posts
    # RedditApi.import_posts_to_db(posts)
    first_post = Post.first
    comments = RedditApi.get_comments_of_post(first_post)
    RedditApi.import_comments_to_db(comments)
    # self.front_page
  end

  # def self.front_page
  #   Post.all.each_with_index do |post, i|
  #    entry =  <<-heredoc
  #         --------------------------------------------
  #        #{i}. #{post.title}
  #              by #{post.author}    submitted #{Time.now.hour - post.created_at.hour} hours ago
  #     heredoc
  #     puts entry
  #   end
  # end



end



# a = CLIRunner.new
# a.run
