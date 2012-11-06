require 'sqlite3'

class Database < SQLite3::Database
  DEV_DB = File.dirname(__FILE__) + '/development.db'
  SCHEMA = File.dirname(__FILE__) + '/schema.sql'

  attr_reader :filename

  def initialize(db_file = DEV_DB)
    super(db_file)
    @filename = db_file
  end

  def self.create(db_file = DEV_DB)
    system("touch #{db_file}") unless File.exists?(db_file)

    self.load_schema(db_file)

    new(db_file)
  end

  def self.load_schema(db_file)
    system("sqlite3 #{db_file} < #{SCHEMA}")
  end

  def find_by_id(table, id)
    execute("SELECT * FROM #{table} WHERE id = \'#{id}\'").flatten
  end

  def delete_rows(table)
    execute("DELETE FROM #{table};")
  end

  def row_count(table)
    execute("SELECT COUNT(*) FROM #{table};").flatten.first
  end

  def reset_ids(table)
    execute("DELETE FROM sqlite_sequence WHERE name = ?", table)
  end
end