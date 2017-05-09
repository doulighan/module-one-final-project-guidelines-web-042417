require_relative 'RedditApi.rb'


def run()
  puts "Welcome to CLI reddit"
  puts ' '
  puts 'display top 25 posts?'
  input = gets.strip
  if input == y
    display_top_25_posts()
  end
end