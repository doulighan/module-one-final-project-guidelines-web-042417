class CLI

  attr_accessor :posts, :comments, :current_page, :prev_posts, :prev_comments, :pages, :depth
    def initialize
      @current_page = Post
      @last_page = Post
      @comments = nil
      @in_comments = false
      @posts = nil
      @pages = []
      @prev_posts = []
      @prev_comments = []
    end

    def run
      puts "Loading...".white
      Import.to_database
      Display.welcome
      display_page
      get_input
    end

    def get_input
      puts "+++++++++++++++++++++++++++++++++++++++++++++++".white
      puts "\nWhat would you like to do?\n".red
      @input = gets.chomp.downcase
      puts "+++++++++++++++++++++++++++++++++++++++++++++++".white
      parse_input
    end

    def parse_input

      if @input.to_i >=1
        @input = @input.to_i
        if @in_comments
          Display.expand_comment(@comments, @input)
          puts "+++++++++++++++++++++++++++++++++++++++++++++++".white
          puts "Enter (s) to go to this subreddit".white
          puts "Enter (b) to go back".white
          puts "Enter (h) to go to the frontpage".white
          puts "Enter (q) to quit".white
        else
          @in_comments = true
          @comments = Display.comments_page(@posts, @input)
          puts "+++++++++++++++++++++++++++++++++++++++++++++++".white
          puts "Enter (1-10) to expand comment".white
          puts "Enter (s) to go to this subreddit".white
          puts "Enter (b) to go back".white
          puts "Enter (h) to go to the frontpage".white
          puts "Enter (q) to quit".white
        end
      else

        case @input

        when 'b'
          back
          @in_comments = false
        when 's'
          puts "\n Loading Subreddit ... \n".red
          go_to_subreddit
          @in_comments = false
        when 'h'
          return_home
          @in_comments = false
        when 'q'
          puts "\n\n  Goodbye! \n\n".red
          exit
        else
          @in_comments = false
          puts "That is not a valid input. Please try again".red
        end
      end
      get_input
    end


    def return_home
      display_page(Post)
      @last_page = Post
    end

    def display_page(current_page=@current_page)
      posts = Display.top_posts(current_page)
      puts Display.thread_header(posts).white
      puts "+++++++++++++++++++++++++++++++++++++++++++++++".white
      puts "Enter (1-10) to view post".white
      puts "Enter (h) to go to the frontpage".white
      puts "Enter (q) to quit".white
      @posts = posts
    end

    def go_to_subreddit
      @posts = Import.subreddit_to_database(@comments[1])
      puts Display.subreddit_header(@posts).white
      puts "+++++++++++++++++++++++++++++++++++++++++++++++".white
      puts "Enter (1-10) to view post".white
      puts "Enter (h) to go to the frontpage".white
      puts "Enter (q) to quit".white
      @last_page = @comments[1].subreddit
    end

    def back
      Display.top_posts(@last_page)
      puts "+++++++++++++++++++++++++++++++++++++++++++++++".white
      puts "Enter (1-10) to view post".white
      puts "Enter (h) to go to the frontpage".white
      puts "Enter (q) to quit".white
      @current_page = @last_page
    end




end
