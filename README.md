# OMDB query using Sidekiq & Sinatra

run ```rake db:create```
run ```rake db:migrate```
run ```redis-server```
run ```bundle exec sidekiq -r ./app.rb```

Navigate to localhost:1234/

Put a movie title into the text field.

Displayed movies on localhost:1234/movies
