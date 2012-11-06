require 'nokogiri'
require 'open-uri'
require_relative 'quote'

class MovieQuotes

  attr_accessor :quotes

  def initialize
    @quotes = []
  end

  def self.from_imdb(url)
    doc = Nokogiri::HTML(open(url))
    movie = MovieQuotes.new
    tweetable_quotes = doc.css(".sodatext").reject { |quote| quote.text.length > 140 }
    movie.quotes = tweetable_quotes.map { |quote| Quote.from_imdb(quote) }
    movie
  end

  def self.from_db
    quote_ids = Database.new.execute("SELECT id FROM quotes;")
    movie = MovieQuotes.new
    quote_ids.each do |id|
      movie.quotes << Quote.from_db(id)
    end
    movie
  end

  def save_all
    quotes.map(&:save)
  end

end