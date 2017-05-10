class CLI

  def self.run

    Import.to_database
    Display.top_posts(20)
    
  end



end
