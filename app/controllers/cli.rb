class CLI
  
  attr_accessor :comment, :comments, :post, :posts, :input, :subreddit

  def initialize
    @comment
    @comments 
    @posts
    @post
    @input
    @subreddit

    self.homepage
    @input = self.get_input
  end

  
  def self.run
    #Import.to_database
    homepage
    input = get_input
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
  end

  def self.handle_input(input)
    case input
      where "q"
        CLI.exit
      where %w(1 2 3 4 5 6 7 8 9 10).include?(input)
        input.to_i
      where
        input 
    end
  end

  



    while(true)
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

  def self.exit
    puts " GOODBYE!"
    abort 
  end

  def self.get_input
    gets.strip
  end


