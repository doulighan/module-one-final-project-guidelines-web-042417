class CLI
  def self.run
    Import.to_database
    Display.top_posts(20)
    puts ""
    puts ""
    puts "Welcome to Reddit CLI!"
    puts ""
    puts ""
    puts "Enter post number to view comments..."

  end
end
