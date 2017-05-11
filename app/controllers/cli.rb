class CLI
  def self.run
   
    Import.to_database
    Display.welcome
    posts = Display.top_posts

    while(true)
      puts "Enter post number to view comments" 
      puts "(q) to quit"
      
      input = gets.chomp.to_i
      
      if input == "q"
        break
      end

      comments = Display.comments_page(posts, input)
      while(true)
        puts " "
        puts "Enter number (1-10) to view comment replies"
        puts "Enter (s) to go to this subreddit page"

        input = gets.chomp

        if input == "s"
          Import.subreddit_to_database(comments[1])
          puts "************* /r/#{comments[1].post.subreddit_title} **************/n"
          Display.top_posts(comments[1].subreddit)
        elsif input.to_i <= 10
          Display.expand_comment(comments, input)
        elsif input == "q"
          #quit
        end
      end
    end


  end
end
