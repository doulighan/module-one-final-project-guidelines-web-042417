
class Display



  def self.welcome
    puts ""
    puts ""
    puts "Welcome to Reddit CLI!"
    puts ""
    puts ""
  end

  def self.top_posts(limit=10)
    result = {}
    Post.limit(limit).each_with_index do |post, i|
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

 



  def self.comments_page(top_posts, input)
    result = {}
    post = top_posts[input]
    comments = Comment.where(parent_id: post[:post_id]).order("score DESC").limit(10)

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
#      c =  <<-heredoc
# ---------------------------------------------------------------------------------


# ---------------------------------------------------------------------------------
#       User: #{comments[i]author}      submitted #{Time.now.hour - post.created_at.hour} hours ago
#         #{comment.body}
#        heredoc
      # puts entry 
      comments.each_with_index do |comment, idx|
         entry = <<-heredoc
      (#{i+1})--------------------------------------------------------------------------------
       User: #{comment.author}      submitted #{Time.now.hour - post.created_at.hour} hours ago
         #{comment.body} #{nested_comment.descendants.each {|com| puts com.body } if idx + 1 == i}
          heredoc
          binding.pry
          puts entry
        result[i+1] = comment
      end




  end 
end













