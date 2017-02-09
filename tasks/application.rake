desc 'Run the Application'

task :server do
  # Trap allows for "graceful" exit without stack trace in terminal
  trap('SIGINT') { exit }
  # Starts server
  ruby 'config.ru'
end
task :s => :server

desc 'Start Sidekiq for asynchronous worker actions'
namespace :run do
  task :sidekiq do
    system 'bundle exec sidekiq -r ./app.rb'
  end
end

desc 'Custom console for Sinatra application'
task :console do
  Kernel.exec 'bundle exec pry -r ./app.rb'
  trap('SIGINT') do
    puts "Exiting Sinatra/Pry console"
    exit 130
  end
end
task :c => :console
