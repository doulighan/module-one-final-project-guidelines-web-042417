class CLI

  attr_accessor :posts, :comments, :current_page, :prev_posts, :prev_comments, :pages, :input, :prev_input
    def initialize
      @current_page = Post
      @last_page = Post
      @comments = nil
      @in_comments = false
      @posts = nil
      @prev_input = nil
      @input = nil
      # @pages = []
      # @prev_posts = []
      # @prev_comments = []
    end

    def run
      puts "Loading...".white
      #Import.to_database
      Display.welcome
      display_page
      get_input
    end

    def get_input

      puts "\nWhat would you like to do?\n".blue
      @input = gets.chomp.downcase
      parse_input
    end

    def parse_input

      if @input.to_i >= 1 && input.to_i <= 10
        @input = @input.to_i
        if @in_comments && @input == @prev_input
          Display.expand_comment_plus_one(@comments, @input)
          @prev_input = @input
        elsif @in_comments
          Display.expand_comment(@comments, @input)
          @prev_input = @input
          puts "\nEnter (s) to go to this subreddit".white
          puts "Enter (b) to go back".white
          puts "Enter (h) to go to the frontpage".white
          puts "Enter (q) to quit".white
        else
          @comments = Display.comments_page(@posts, @input)
          puts "________________________________________________".blue
          puts "Enter (1-10) to expand comment".white
          puts "Enter (s) to go to this subreddit".white
          puts "Enter (b) to go back".white
          puts "Enter (h) to go to the frontpage".white
          puts "Enter (q) to quit".white
                    @in_comments = true

        end
      else

        case @input

        when 'b'
          back
          @in_comments = false
        when 's'
          if @in_comments
            puts "\n Loading Subreddit ... \n".blue
            go_to_subreddit
            @in_comments = false
          else
            puts "That is not a valid input. Please try again".red
          end
        when 'h'
          return_home
          @in_comments = false
        when 'f'
          p "Search:"
          search_for_subreddit(gets.strip.downcase)
          @in_comments = false
        when 'q'
          puts "\n\n  Goodbye! \n\n".blue
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
      puts Display.thread_header(posts).blue
      #puts "________________________________________________".blue
      puts "Enter (1-10) to view post".white
      puts "Enter (h) to go to the frontpage".white
      puts "Enter (q) to quit".white
      @posts = posts
    end

    def go_to_subreddit
      @posts = Import.subreddit_to_database(@comments[1])
      puts Display.subreddit_header(@posts).blue
      #puts "________________________________________________".blue
      puts "Enter (1-10) to view post".white
      puts "Enter (h) to go to the frontpage".white
      puts "Enter (q) to quit".white
      @last_page = @comments[1].subreddit
    end

    def back
      @posts = Display.top_posts(@last_page)
      if @last_page == Post
        puts Display.thread_header(@posts).blue
      else 
        puts Display.subreddit_header(@posts).blue
      end
      #puts "________________________________________________".blue
      puts "Enter (1-10) to view post".white
      puts "Enter (h) to go to the frontpage".white
      puts "Enter (q) to quit".white
      @current_page = @last_page
    end

    def search_for_subreddit(string)
      begin
        subreddit = Import.search_subreddit_to_database(string)
        puts "\nLoading...".white
        puts Display.subreddit_header(@posts).blue
        #puts "________________________________________________".blue
        puts "Enter (1-10) to view post".white
        puts "Enter (h) to go to the frontpage".white
        puts "Enter (q) to quit".white
        @last_page = subreddit
      rescue
        puts "\nSub not found!".red
      end
    end




end
