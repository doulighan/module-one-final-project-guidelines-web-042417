class CLI
  def self.run
   
    #Import.to_database
    
    Display.welcome

    while(true)
      posts = Display.top_posts
      puts "Enter post number to view comments" 
      puts "(q) to quit"
      
      input = gets.chomp.to_i
      
      if input == "q"
        break
      end

      comments = Display.comments_page(posts, input)
      while(true)
        puts " "
        puts "Enter number to expand comment"
        puts "Enter (s) to go to subreddit page"
        puts "Enter (q) to go back to posts"
      
        input = gets.chomp
        if input == "q"
          break
        elsif input == "s"
          Import.subreddit_to_database(comments[1])
          puts "************* /r/#{comments[1].post.subreddit_title} **************/n"
          Display.top_posts(comments[1].subreddit)
          binding.pry
        end
      end
    end


  end
end
