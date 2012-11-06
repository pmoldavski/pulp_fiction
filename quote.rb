require 'nokogiri'
require 'open-uri'
require_relative 'database'

class Quote

  attr_accessor :body
  attr_reader :id

  def initialize(params = {})
    @body = params.fetch(:body)
    @id = params.fetch(:id) { nil }
    @db = Database.new
  end

  def self.from_imdb(quote)
    Quote.new :body => quote.text
  end

  def self.from_db(id)
    record = Database.new.execute("SELECT * FROM quotes WHERE id = ?", id).flatten
    Quote.new(:body => record[1], :id => record[0])
  end

  def save
    unless has_duplicate?
      @db.execute("INSERT INTO quotes ( body ) VALUES ( ? )", @body)
      @id = @db.last_insert_row_id
    else
      p "This quote has already been saved"
    end
  end

  def has_duplicate?
    !@db.execute("SELECT * FROM quotes WHERE body = ?", @body).empty?
  end

end






# My test scrape:
# doc = Nokogiri::HTML(open('http://www.imdb.com/title/tt0110912/quotes'))
# File.open('test_scrape.html', 'w') {|f| f.write(doc) }
