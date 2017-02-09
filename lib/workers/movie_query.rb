class MovieQueryWorker
  include Sidekiq::Worker

  def perform(movie_title)
    title = movie_title.gsub(" ", "+").downcase
    puts "Searching for #{title}"
    @query = "http://www.omdbapi.com/?t=#{title}&y=&plot=short&r=json"
    movie = sort_movie_params(get_movie_from_omdb)
    puts movie
    Movie.create(movie)
  end

  def get_movie_from_omdb
    uri = URI.parse(@query)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def sort_movie_params(movie)
    movie = Hash[movie.map {|k, v| [k.downcase, v] }]
    movie.select { |k, v| permitted_params.include?(k) }
  end

  def permitted_params
    %w(title year rated released runtime)
  end

end

