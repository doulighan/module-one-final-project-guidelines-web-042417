class CLI
  def self.run
    #Import.to_database
    posts = Display.top_posts(20)
    
    Display.welcome

    while(true)
      puts "Enter post number to view comments or (q) to quit..."
      input = gets.chomp.to_i
      if input == "q"
        break
      end

      while(true)
        comments = Display.comments_page(posts, input)
        puts " "
        puts "Enter number to expand comment, or (q) to go back to posts"
        input = gets.chomp.to_i
        if input == "q"
          break
        end
        comments = Display.expand_comment(comments, input)
      end
    end


  end
end
