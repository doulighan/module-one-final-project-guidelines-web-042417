
class Display



  def self.welcome
    puts ""
    puts ""
    puts "Welcome to Reddit CLI!"
    puts ""
    puts ""
  end

  def self.top_posts(origin=Post)
    if origin != Post
      origin = origin.posts
    result = {}
    origin.limit(5).each_with_index do |post, i|
     entry =  <<-heredoc
---------------------------------------------------------------------------------
    #{i+1}. #{post.title}
    by #{post.author}    submitted #{Time.now.hour - post.created_at.hour} hours ago
      heredoc
      puts entry
      result[i+1] = post
    end
    result
  end



  # def self.child_comments(comment, i=nil)

  # end

  def self.comments_page(top_posts, input)
    result = {}
    post = top_posts[input]
    comments = Comment.where(parent_id: post[:post_id]).order("score DESC").limit(4)

    entry =  <<-heredoc


---------------------------------------------------------------------------------
    #{post.title}
    by #{post.author}    submitted #{Time.now.hour - post.created_at.hour} hours ago
---------------------------------------------------------------------------------
    Comments:

    heredoc

    comments.each_with_index do |comment, i|
      entry = <<-heredoc
(#{i+1})--------------------------------------------------------------------------------
  User: #{comment.author}      submitted #{Time.now.hour - post.created_at.hour} hours ago
    #{comment.body}
    heredoc
    puts entry
    result[i+1] = comment
    end
    result
  end

  def self.expand_comment(comments, i)
      nested_comment = comments[i]
      nest_proc = Proc.new { |arg, child_idx|
         <<-heredoc
              (#{"***"})--------------------------------------------------------------------------------
               User: #{arg.author}      submitted #{Time.now.hour - 1} hours ago
                 #{arg.body}
            heredoc
      }

      comments.values.each_with_index do |comment, idx|
         entry = <<-heredoc
      (#{idx + 1})--------------------------------------------------------------------------------
       User: #{comment.author}      submitted #{Time.now.hour - 1} hours ago
         #{comment.body}
          heredoc
          # binding.pry
          puts entry
          nested_comment.children.each {|child| puts nest_proc.call(child, idx)} if idx + 1 == i
      end
  end

  # def self.children_comments(comment)
  # end
end
