class CLI
  def self.run

    Import.to_database
    Display.welcome
    posts = Display.top_posts






    while(true)
      puts " "
      puts "************* CURRENTLY VIEWING: FRONT PAGE *************"
      puts " "
      puts "Enter post number (1-10) to view its comments"
      puts "Enter (q) to quit "
      puts " "

      input = gets.chomp.to_i
      exit if input == "q"

      comments = Display.comments_page(posts, input)
      post = comments[1].post
      while(true)
        puts " "
        puts "************* CURRENTLY VIEWING: #{post.title.upcase} **************"
        puts "  "
        puts "Enter number (1-10) to view comment replies"
        puts "Enter (s) to go to this subreddit page"
        puts "Enter (b) to go back"
        puts "Enter (q) to quit "
        puts " "

        input = gets.chomp

        if input == "s"
          Import.subreddit_to_database(comments[1])
          puts "************* /r/#{comments[1].post.subreddit_title} **************\n"
          Display.top_posts(comments[1].subreddit)

        elsif input.to_i <= 10
          Display.expand_comment(comments, input)

        elsif input == "q"
          exit
        else
          puts " "
          puts " INVALID COMMAND "
          puts " "
        end
      end
    end


  end
end
