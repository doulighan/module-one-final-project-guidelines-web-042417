class RedditParser
  attr_accessor :url
  def initialize(url)
    @url = url
  end

  def get_posts
    url = self.url
    all_posts = []
    posts = RestClient.get(url)
    json_posts = JSON.parse(posts)
    all_posts << json_posts["data"]["children"]
    all_posts


  end

  def get_comments
  end

#   def get_all_char_data(url)
#   all_characters = []
#   return all_characters if url == nil
#
#   characters = RestClient.get(url)
#   json_characters = JSON.parse(characters)
#   all_characters << json_characters["results"]
#   new_url = json_characters["next"]
#   all_characters + get_all_char_data(new_url)
# end
#
# def all_characters
#   characters = get_all_char_data('http://www.swapi.co/api/people/')
#   characters.flatten!
#   characters.each_with_index do | character_hash, i |
#     characters[i] = { character_hash["name"] => character_hash}
#   end
#
#   characters.inject { |accum, el| accum.merge(el)}
# end
#
# def get_character_movies_from_api(character)
#   all_characters[character]["films"].map {| film_url | RestClient.get(film_url) }
# end
#
# def parse_character_movies(films_hash)
#    films_hash.map { |film_data| JSON.parse(film_data)["title"]}
# end
#
# def show_character_movies(character)
#   films_hash = get_character_movies_from_api(character)
#   films = parse_character_movies(films_hash)
#   films.each_with_index do |film, i|
#     puts "#{i + 1}. #{film}"
#   end
# end

end
