class CLI

  attr_accessor :posts, :comments, :current_page, :prev_posts, :prev_comments, :pages, :main_page
    def initialize
      @current_page = Post
      @last_page = []
      @comments = nil
      @in_comments = [false, nil]
      @main_page = true
      @posts = []
      @pages = []
      @prev_posts = []
      @prev_comments = []
    end

    def run
      #
      # Import.to_database
      Display.welcome
      @posts << Display.top_posts
      home

      ###@posts = front page posts
      Display.options
      get_input

    end

    def get_input
      puts "What would you like to do?"
      @input = gets.chomp.downcase
      parse_input
    end

    def parse_input
      @posts.empty? ? @posts << Post : nil
      if @input.to_i >=1
        @input = @input.to_i
        if @in_comments[0] && (@in_comments[1] == @input)
          @comments = Display.expand_comment_plus_one(@comments, @input)
          @in_comments[1] = nil
        elsif @in_comments[0]
          @comments = Display.expand_comment(@comments, @input)
          @in_comments[1] = @input
        else
          @in_comments[0] = true
          @comments = Display.comments_page(@posts.pop, @input)
          @last_page << @current_page
          @current_page = @comments[1].subreddit
        end
        # debugger
      else

        case @input
        when 'b'
            back
          @in_comments[0] = false
        when 's'
          go_to_subreddit
          @in_comments[0] = false
        when 'h'
          home
          @in_comments[0] = false
        when 'q'
          exit
        else
        
          @in_comments = false
          puts "That is not a valid input. Please try again"
        end
      end
      Display.options
      get_input
    end



    def home
      if @current_page == Post
        return
      else
         Display.top_posts(Post)
         @posts << Post
        @last_page << @current_page
        @current_page = Post
      end
    end

    # def display_page(current_page=@current_page)
    #   @posts = Display.top_posts(current_page)
    #   @last_page << @current_page
    #   @main_page ? nil : go_to_subreddit
    #   # @posts = posts
    # end
    ### 1 => redirect to post 1
    ###in page
    def go_to_subreddit
      @posts << Import.subreddit_to_database(@comments[1])
      @main_page = false
      @last_page << @current_page
      @current_page = @comments[1].subreddit
    end

    def back
      @last_page.length > 1 ?  @current_page = @last_page.pop : @current_page = @last_page[0]
      @in_comments = [false, nil]
      Display.top_posts(@current_page)
    end





  #   while(true)
  #
  #
  #     input = gets.chomp.to_i
  #
  #     ###got error...if you dont type 1-10, turns to zero, then comments below dont work because posts[0] does not exist
  #     exit if input == "q"
  #
  #     comments = Display.comments_page(posts, input)
  #     binding.pry
  #     post = comments[1].post
  #     while(true)
  #       puts " "
  #       puts "************* CURRENTLY VIEWING: #{post.title.upcase} **************"
  #       puts "  "
  #       puts "Enter number (1-10) to view comment replies"
  #       puts "Enter (s) to go to this subreddit page"
  #       puts "Enter (b) to go back"
  #       puts "Enter (q) to quit "
  #       puts " "
  #
  #       input = gets.chomp
  #
  #       if input == "s"
  #         Import.subreddit_to_database(comments[1])
  #         puts "************* /r/#{comments[1].post.subreddit_title} **************\n"
  #         Display.top_posts(comments[1].subreddit)
  #
  #       elsif input.to_i <= 10
  #         Display.expand_comment(comments, input)
  #
  #       elsif input == "q"
  #         exit
  #       else
  #         puts " "
  #         puts " INVALID COMMAND "
  #         puts " "
  #       end
  #     end
  #   end
  #
  #
  # end
end
