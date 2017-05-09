class CLI

  def self.run
    puts "Welcome to CLI reddit"
    puts "Here's what's trending right now"
    sleep(2.0)
    system("clear")
    # posts = RedditApi.get_hash_of_top_posts
    # RedditApi.import_posts_to_db(posts)
    self.front_page
  end

  def self.front_page
    Post.all.each_with_index do |post, i|
     entry =  <<-heredoc
          --------------------------------------------
         #{i}. #{post.title}
               by #{post.author}    submitted on #{post.created_at}
      heredoc
      puts entry
    end
  end



end



# a = CLIRunner.new
# a.run
