
class Display



  def self.welcome
    puts ""
    puts ""
    puts "Welcome to Reddit CLI!"
    puts ""
    puts ""
  end
  def self.top_posts(origin=Post)
    result = {}
    origin != Post ? origin = origin.posts : nil
    thread_header(origin)
    origin.limit(10).each_with_index do |post, i|
      print_post(post, i)
      result[i+1] = post
    end

    result
  end


  def self.comments_page(top_posts, input)
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

  def self.expand_comment(comments, n)
    i = n.to_i
    nested_comment = comments[i]

    comments.values.each_with_index do |comment, idx|
      print_comment(comment, idx)
      if idx + 1 == i
        nested_comment.children[0..4].each { |child| print_comment(child)}
         break
      end
    end
  end

  def self.thread_header(posts)
    page_title = posts.is_a?(Array) ? posts.first.subreddit.title  : "FRONTPAGE"
    <<-heredoc
    ___________________________________________________________________________
    #{page_title}
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
    (#{maybe_counter.is_a?(String) ? maybe_counter : maybe_counter.call(i)})--------------------------------------------------------------------------------
    User: #{comment.author}  (#{comment.score})      submitted #{Time.now.hour -  1} hours ago
    #{comment.body}
    heredoc

    puts comment
  end
end
