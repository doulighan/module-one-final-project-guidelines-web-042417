class CLI

  def self.run

    Import.to_database
   
    puts " "
    puts " "
    puts "Welcome to CLI reddit"
    puts "Here's what's trending right now"


    Display.top_posts(5)
    



  end



end
