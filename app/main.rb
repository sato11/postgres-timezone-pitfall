require 'active_record'

db_config_file_path = File.join(File.expand_path('..', __FILE__), '..', 'db', 'config.yml')
db_config = YAML.load(File.read(db_config_file_path))

ActiveRecord::Base.default_timezone = :local
ActiveRecord::Base.establish_connection(db_config['development'])

query1 = 'SELECT current_timestamp AS now'
query2 = ActiveRecord::Base.sanitize_sql_array(['SELECT ? AS now', Time.now.to_s])

print 'query1: '
puts ActiveRecord::Base.connection.exec_query(query1).rows

print 'query2: '
puts ActiveRecord::Base.connection.exec_query(query2).rows
