desc 'Run the Application'

task :s do
  # Trap allows for "graceful" exit without stack trace in terminal
  trap('SIGINT') { exit }
  # Starts server
  ruby 'config.ru'
end

task :sidekiq do
  system 'bundle exec sidekiq -r ./app.rb'
end
