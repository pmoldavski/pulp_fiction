require_relative 'movie_quotes'
require_relative 'quote'
require_relative 'database'

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

load_from_imdb.save_all
p random_quote = rand_quote_from_db
p random_quote.body
#
# puts pulp_fiction.quotes.first.body
# puts "____________________________"
# puts pulp_fiction.quotes.last.body
#
