class CLI
  def self.run
   
    #Import.to_database
    
    Display.welcome
    Import.subreddit_to_database(Comment.last)

    while(true)
      posts = Display.top_posts
      puts "Enter post number to view comments" 
      puts "(q) to quit"
      
      input = gets.chomp.to_i
      
      if input == "q"
        break
      end

      while(true)
        comments = Display.comments_page(posts, input)
        puts " "
        puts "Enter number to expand comment"
        puts "Enter (s) to go to subreddit page"
        puts "Enter (q) to go back to posts"
        input = gets.chomp

        if input == "q"
          break
        elsif input == "s"
          Import.subreddit_to_database(comments[1])
          Display.top_posts(comments[1].subreddit)
          
        elsif
        comments = Display.expand_comment(comments, input)
        end
      end
    end


  end
end
