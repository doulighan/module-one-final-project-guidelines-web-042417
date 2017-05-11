class CLI
  
  attr_accessor :comment, :comments, :post, :posts, :input, :subreddit, :state

  def initialize
    @comments 
    @posts
    @page = nil
    @state  = nil
    @prev_state = nil
    @state_objects = nil
  end


  
  def run
   # Import.to_database
    self.homepage
  end

  def state_selector(input)
    while true
      if input == "q"
        CLI.exit
     
      elsif input == "s"
        if state == "comments"
          self.subreddit_page
        end

      elsif input.to_i.between?(1, 10)
        self.comments_page(input.to_i)
      
      else
        puts "INVALID COMMAND"
        input = gets.strip
      end
    end
  end
  


  def homepage
    Display.welcome
    @posts = Display.top_posts

    puts " "
    puts "************* CURRENTLY VIEWING: FRONT PAGE *************"
    puts " "
    puts "Enter post number (1-10) to view its comments" 
    puts "Enter (q) to quit "
    puts " "

    @prev_state = state
    @state = "homepage"

    self.state_selector(gets.strip)
  end



  def comments_page(input)
    @comments = Display.comments_page(@posts, input)
    puts " \n"
    puts "*********************************************************************************"
    puts "    CURRENTLY VIEWING: #{@posts[input].title}\n"
    puts "Enter number (1-10) to view comment replies"
    puts "Enter (s) to go to this subreddit page"
    puts "Enter (b) to go back"
    puts "Enter (q) to quit "
    puts " "
    @prev_state = @state
    @state = "comments"
    input = gets.strip
    if input.to_i.between?(1, 11)
      self.expand_comments(comments, input.to_i)
    else
      state_selector(input)
    end
  end

  
  # def back
  #   case @state 
  #   when "comments"
  #   end
  # end


  def expand_comments(comments, input)
    Display.expand_comment(comments, input)
    @state = "expanded comments"
    puts " "
    puts "************* CURRENTLY VIEWING: EXPANDED COMMENT **************"
    puts "  "
    puts "Enter (b) to go back"
    puts "Enter (q) to quit "
    puts " "
    input = gets.strip
    if input == "b"
      self.homepage
    end
  end

  
  def subreddit_page
    Import.subreddit_to_database(@comments[1])
    
    posts = Display.top_posts(comments[1].subreddit)
    puts "\n" 
    puts "************* /r/#{@comments[1].post.subreddit_title} **************\n"
    puts " "
    puts "Enter (b) to go back"
    puts "Enter (q) to quit "
    puts " "

    @state = "subreddit"
    input = gets.strip
    if input == "b"
      self.homepage
    elsif input == "q"
      CLI.exit
    end
  end

  


# def
#     while(true)
#       input = gets.chomp.to_i
#       exit if input == "q"
      
#       comments = Display.comments_page(posts, input)
#       post = comments[1].post
#       while(true)
#         puts " "
#         puts "************* CURRENTLY VIEWING: #{post.title.upcase} **************"
#         puts "  "
#         puts "Enter number (1-10) to view comment replies"
#         puts "Enter (s) to go to this subreddit page"
#         puts "Enter (b) to go back"
#         puts "Enter (q) to quit "
#         puts " "

#         input = gets.chomp

#         if input == "s"
#           Import.subreddit_to_database(comments[1])
#           puts "************* /r/#{comments[1].post.subreddit_title} **************\n"
#           Display.top_posts(comments[1].subreddit)

#         elsif input.to_i <= 10
#           Display.expand_comment(comments, input)
        
#         elsif input == "q"
#           exit
#         else
#           puts " "
#           puts " INVALID COMMAND "
#           puts " "
#         end
#       end
#     end

  def self.exit
    puts " GOODBYE!"
    abort 
  end

  def self.get_input
    gets.strip
  end
end

