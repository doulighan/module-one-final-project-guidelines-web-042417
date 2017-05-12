
class Display
  ##must be called independtly
  def self.welcome
    puts ""
    puts ""
    puts "Welcome to Reddit CLI!"
    puts ""
    puts ""
  end

  def self.options
  puts  <<-heredoc
    'b' to go back, 's' to go to subreddit, 1-10 to select a post or comment,
    'h' to go home, 'q' to exit.
    heredoc
  end

  ### gives nothing or a subreddit obj
  def self.top_posts(origin=Post)
    result = {}

    origin != Post ? origin = origin.posts : nil
    thread_header(origin)
    origin.limit(10).each_with_index do |post, i|
      print_post(post, i)
      result[i+1] = post
    end

     result ##posts with integer
  end


  def self.comments_page(top_posts, input)
    binding.pry
    post = top_posts[input]
    comments = Comment.where(parent_id: post[:post_id]).order("score DESC").limit(10)
    print_title_post(post)
    comment_printer(comments)
  end

  def self.comment_printer(comments)
      result = {}
      comments.each_with_index do |comment, i|
        print_comment(comment, i)
        result[i + 1] = comment
      end

      result
  end

  def self.expand_comment_plus_one(comments, i)
    result = {}
    nested_comment = comments[i]

    comments.values.each_with_index do |comment, idx|
      if idx + 1 < i
        print_comment(comment, idx)
      end
      result[idx + 1] = comment
      if idx + 1 == i
        nested_comment.children[0..3].each do |child|
          print_comment(child)
          child.children[0..3].each do |grandchild|
           puts <<-grandchild
               child_reply:(#{"*****"})--------------------------------------------------------------------------------
               User: #{grandchild.author}  (#{grandchild.score})      submitted #{Time.now.hour -  1} hours ago
               #{grandchild.body}
           grandchild
          end
        end

      end
    end

    result
  end
  def self.expand_comment(comments, i)
    result = {}
    nested_comment = comments[i]

    comments.values.each_with_index do |comment, idx|
      print_comment(comment)
      if idx + 1 == i
        nested_comment.children[0..3].each do |child|
          print_comment(child)
        end
      end
      result[idx + 1] = comment
    end

    result
  end

  def self.thread_header(page)
    page_title = page.is_a?(Array) ? page.first.subreddit.title.upcase  : "FRONTPAGE"
    <<-heredoc
    ___________________________________________________________________________
    *****CURRENTLY VIEWING***** :#{page_title}
    _________________________________________________________________________
    heredoc
  end


  def self.print_post(post, i)
    result = <<-heredoc
    ---------------------------------------------------------------------------------
    #{i+1}. #{post.title}   (#{post.subreddit_title})
    by #{post.author}    submitted #{Time.now.hour - post.created_at.hour} hours ago
    heredoc
    puts result
  end

  def self.print_title_post(post)
    title_post =  <<-heredoc
    ---------------------------------------------------------------------------------
    #{post.title}
    by #{post.author}    submitted #{Time.now.hour - post.created_at.hour} hours ago
    ---------------------------------------------------------------------------------
    Comments:

    heredoc

    puts title_post
  end

  def self.print_comment(comment, i=nil)
    i.nil? ? maybe_counter = "***" : maybe_counter = Proc.new {|arg| arg += 1 }
    comment = <<-heredoc
    #{maybe_counter.is_a?(String) ? 'reply: (' + maybe_counter : '(' + maybe_counter.call(i).to_s})--------------------------------------------------------------------------------
    User: #{comment.author}  (#{comment.score})      submitted #{Time.now.hour -  1} hours ago
    #{comment.body}
    heredoc

    puts comment
  end
end
