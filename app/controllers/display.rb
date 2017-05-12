
class Display
  ##must be called independtly
  def self.welcome
    puts ""
    puts ""
    puts "Welcome to Reddit CLI!"
    puts ""
    puts ""
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
    result = {}
    post = top_posts[input]
    comments = Comment.where(parent_id: post[:post_id]).order("score DESC").limit(10)
    comments.each_with_index do |comment, i|
      comment_generator(comment, i + 1)
      result[i + 1] = comment
    end
    result
  end

  # def self.comment_printer(comments)
  #     result = {}
  #     comments.each_with_index do |comment, i|
  #       print_comment(comment, i)
  #       result[i + 1] = comment
  #     end
  #
  #     result
  # end

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

  # def self.print_comment(comment, i=nil)
  #   i.nil? ? maybe_counter = "***" : maybe_counter = Proc.new {|arg| arg += 1 }
  #   comment = <<-heredoc
  #   #{maybe_counter.is_a?(String) ? 'reply: (' + maybe_counter : '(' + maybe_counter.call(i).to_s})--------------------------------------------------------------------------------
  #   User: #{comment.author}  (#{comment.score})      submitted #{Time.now.hour -  1} hours ago
  #   #{comment.body}
  #   heredoc

  #  puts comment
  # end


  def self.thread_header(posts)
    page_title = posts.is_a?(Array) ? posts.first.subreddit.title.upcase  : "FRONTPAGE"
    <<-heredoc
________________________________________________________________________________
    ***** CURRENTLY VIEWING: #{page_title} *****
________________________________________________________________________________
    heredoc
  end

  def self.subreddit_header(posts)
    page_title = posts.first[1].subreddit.title.upcase
    <<-heredoc
________________________________________________________________________________
    ***** CURRENTLY VIEWING: #{page_title} *****
________________________________________________________________________________
    heredoc
  end


  def self.print_post(post, i)
    result = <<-heredoc
    #{i+1}. #{post.title}   (#{post.subreddit_title})
    by #{post.author}     (score:#{post.score})      submitted #{Time.now.hour - post.created_at.hour} hours ago
    heredoc
    puts "---------------------------------------------------------------------------------".white
    puts result
  end



  def self.print_title_post(post)
    title_post =  <<-heredoc
    #{post.title}      (#{post.subreddit_title})
    by #{post.author}  (score:#{post.score})  submitted #{Time.now.hour - post.created_at.hour} hours ago
    ---------------------------------------------------------------------------------
    Comments:

    heredoc
    puts "---------------------------------------------------------------------------------".white
    puts title_post
    puts "---------------------------------------------------------------------------------".white

  end

  def self.expand_comment_plus_one(comments, input, depth)
    return if depth < 1
    result = {}
    # binding.pry
    family = [comments[input]] + comments[input].children

   family.each_with_index do |comment, idx|
     comment_generator(comment, idx + 1)
     result[idx + 1] = comment
      if input == idx + 1
        comment.children.each do |child|
          expand_comment_plus_one(result, input, depth - 1)
        end
      end
   end

   result
  end

  def self.comment_generator(comment, index=nil)
    index = comment.parent.nil? ? index : "**" * comment.ancestry.length
    indent = "     "
    # debugger
    comment.parent.nil? ? nil : indent *= comment.ancestry.length
    puts "#{indent}  -------------------------------------------------------------------------"
    puts "#{indent}#{index}."
    puts "#{indent}   by #{comment.author}, #{comment.score}, submitted #{Time.now.hour - 1} hours ago"
    puts "#{indent}      #{comment.body}"

  end
#   def self.expand_comment(comments, i)
#     result = {}
#     nested_comment = comments[i]

#    comments.values.each_with_index do |comment, idx|
#       print_comment(comment)
#       if idx + 1 == i
#         nested_comment.children[0..3].each do |child|
#           print_comment(child)
#         end
#       end
#       result[idx + 1] = comment
#     end

#    result
#   end

# if @input.to_i >=1
#         @input = @input.to_i
#         if @in_comments[0] && (@in_comments[1] == @input)
#           @comments = Display.expand_comment_plus_one(@comments, @input)
#           @in_comments[1] = nil
#         elsif @in_comments[0]
#           @comments = Display.expand_comment(@comments, @input)
#           @in_comments[1] = @input
#         else
#           @in_comments[0] = true
#           @comments = Display.comments_page(@posts.pop, @input)
#           @last_page << @current_page
#           @current_page = @comments[1].subreddit
#         end
  # def self.print_comment(comment, i=nil)
  #   i.nil? ? maybe_counter = "***" : maybe_counter = Proc.new {|arg| arg += 1 }
  #   comment = <<-heredoc
  #   (#{maybe_counter.is_a?(String) ? maybe_counter : maybe_counter.call(i)})--------------------------------------------------------------------------------
  #   User: #{comment.author}  (score:#{comment.score})      submitted #{Time.now.hour -  1} hours ago
  #   #{comment.body}
  #   heredoc
  #
  #   puts comment
  # end
end
