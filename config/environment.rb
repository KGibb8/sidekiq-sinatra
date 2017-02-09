require 'standalone_migrations'

Dir[File.expand_path('../models/*.rb', __dir__)].each { |file| require file }

ActiveRecord::Base.establish_connection(
  YAML.load_file('db/config.yml')[ENV["RAILS_ENV"] || ENV["RACK_ENV"] || "development"]
)
