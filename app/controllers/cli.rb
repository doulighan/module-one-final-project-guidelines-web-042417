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
      #
      # Import.to_database
      Display.welcome
      display_page

      ###@posts = front page posts
      get_input

    end

    def get_input
      puts "What would you like to do?"
      @input = gets.chomp.downcase
      parse_input
    end

    def parse_input
      if @input.to_i >=1
        @input = @input.to_i
        if @in_comments
          Display.expand_comment(@comments, @input)
        else
          @in_comments = true
          @comments = Display.comments_page(@posts, @input)
        end
      else

        case @input
        when 'b'
          back
          @in_comments = false
        when 's'
          go_to_subreddit
          @in_comments = false
        when 'h'
          return_home
          @in_comments = false
        when 'q'
          exit
        else
          @in_comments = false
          puts "That is not a valid input. Please try again"
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
      @posts = posts
    end
    ### 1 => redirect to post 1
    ###in page
    def go_to_subreddit
      @posts = Import.subreddit_to_database(@comments[1])
      @last_page = @comments[1].subreddit
    end

    def back
      Display.top_posts(@last_page)
      @current_page = @last_page
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
