class CLI
  def self.run
    Import.to_database
    posts = Display.top_posts(20)

    Display.welcome

    while(true)
      puts "Enter post number to view comments or (q) to quit..."
      input = gets.chomp.to_i
      system("clear")
      if input == "q"
        break
      end

      while(true)
        comments = Display.comments_page(posts, input)
        puts " "
        puts "Enter number to expand comment, or (q) to go back to posts"
        input = gets.chomp.to_i
        system("clear")
        if input == "q"
          break
        end
        comments = Display.expand_comment(comments, input)
        break
      end
      puts "What would you like to do?"
      # input = gets.chomp.downcase
      decision(input)
    end


  end
end


# def navigate(input)
#   input.downcase!
#   case input
#   when 'next'
#     load_next_page
#   when 'back'
#     back_to_prev_page
#   when 'sub'
#     search_sub
#   when 'comment'
#     add_comment
#   when 'post'
#     add_post
#   when 'q'
#     break
#   when 'help'
#     help
#   end
# end
#
# def help
#   <<-help
#   NEXT: navigate to next search results
#
#   FORWARD = navigate to forward page
#
#   BACK: navigate to previous page
#
#   SUB: search for new subreddit
#
#   COMMENT: add comment
#
#   Q: QUIT
#
#   HELP: display options
#
#   help
# end
#
# def go_back
#
# end
