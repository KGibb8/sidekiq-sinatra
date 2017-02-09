class MovieQueryWorker
  include Sidekiq::Worker

  def perform(movie_title)
    title = movie_title.gsub(" ", "+").downcase
    @query = "http://www.omdbapi.com/?t=#{title}&y=&plot=short&r=json"
    response = make_request
    binding.pry
  end

  def make_request
    uri = URI.parse(@query)
    Net::HTTP.get(uri)
  end

end

