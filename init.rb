require_relative 'movie_quotes'
require_relative 'quote'
require_relative 'database'
require 'twitter'

# Database.create

def load_from_imdb
  MovieQuotes.from_imdb('test_scrape.html')
end

def load_from_db
  MovieQuotes.from_db
end

def rand_quote_from_db
  load_from_db.quotes.sample
end

# load_from_imdb.save_all
# p random_quote = rand_quote_from_db
# p random_quote.body

Twitter.configure do |config|
  config.consumer_key = "CnS2TVyuEDA67m6XZwQhQ"
  config.consumer_secret = "c98lWw3UdxyYY0hK8V5oEYBqN14adsSO5GuM0t4dk"
  config.oauth_token = "929059651-ArZpFKGtHE1QRgrn5evlNMUUna05lpJGF1Dzrm6b"
  config.oauth_token_secret = "Jfn4URKqUxJ8IL4ERxPKMqUphhvHypZzc2eql0k0"
end

quote = rand_quote_from_db

Twitter.update(quote.body)