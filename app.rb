require './config/environment'
require 'sinatra'
require 'sinatra/reloader'
require 'redis'
require './config/sidekiq'
require 'net/http'
require 'action_view'
require 'haml'
require 'pry'

Dir[File.expand_path("./lib/workers/*.rb")].each { |file| require file }

set :run, false

class Application < Sinatra::Base

  set :views, 'views'
  set :root, File.dirname(__FILE__)

  get "/" do
    haml :index
  end

  get '/movies' do
    @movies = Movie.all.order(:title)
    haml :movies
  end

  post "/" do
    MovieQueryWorker.perform_async(params[:title])
    redirect to('/')
  end

end
