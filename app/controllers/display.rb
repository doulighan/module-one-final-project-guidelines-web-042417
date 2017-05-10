
class Display

  def self.top_posts(limit=10)
   
    Post.limit(limit).each do |post, i|
     entry =  <<-heredoc
          --------------------------------------------
         #{i}. #{post.title}
               by #{post.author}    submitted #{Time.now.hour - post.created_at.hour} hours ago
      heredoc
      puts entry
    end
  end
 
end