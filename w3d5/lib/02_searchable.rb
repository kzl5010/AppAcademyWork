require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    parameters = params.keys.map { |key| "#{key} = ?"  }.join(" AND ")

    results = DBConnection.execute(<<-SQL, *params.values)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{parameters}
    SQL

    parse_all(results)
  end
end

class SQLObject
  extend Searchable
end
