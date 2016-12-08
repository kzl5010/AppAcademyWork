require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @columns if @columns
    @columns = DBConnection.execute2(<<-SQL).first
      SELECT
        *
      FROM
        #{table_name}
    SQL

    @columns.map!(&:to_sym)
  end

  def self.finalize!
    self.columns.each do |column|
      define_method(column) do
        self.attributes[column]
      end

      define_method("#{column}=") do |value|
        self.attributes[column] = value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.name.tableize
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
    SQL

    parse_all(results)
  end

  def self.parse_all(results)
    results.map { |result| self.new(result) }
  end

  def self.find(id)
    results = DBConnection.execute(<<-SQL, id)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
      WHERE
        #{table_name}.id = ?
    SQL

    parse_all(results).first
  end

  def initialize(params = {})
    params.each do |attribute, value|
      raise "unknown attribute '#{attribute}'" unless self.class.columns.include?(attribute.to_sym)
      self.send("#{attribute.to_sym}=", value)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    arr = self.class.columns.map do |column|
      self.send("#{column}")
    end
  end

  def insert
    columns = self.class.columns.drop(1)
    column_names = columns.map(&:to_s).join(",")
    questions = (["?"] * columns.count).join(", ")
    DBConnection.execute(<<-SQL, *attribute_values.drop(1))
      INSERT INTO
        #{self.class.table_name} (#{column_names})
      VALUES
        (#{questions})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    column_names = self.class.columns
      .map { |attr| "#{attr} = ?" }.join(", ")
    DBConnection.execute(<<-SQL, *attribute_values, id)
      UPDATE
        #{self.class.table_name}
      SET
        #{column_names}
      WHERE
        #{self.class.table_name}.id = ?
    SQL

  end

  def save
    if id.nil?
      insert
    else
      update
    end
  end
end
