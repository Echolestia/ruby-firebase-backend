namespace :db do
    desc "Empty the database"
    task :empty => :environment do
      tables = ActiveRecord::Base.connection.tables
      tables.each do |table|
        next if table == 'schema_migrations'
        ActiveRecord::Base.connection.execute("TRUNCATE #{table} RESTART IDENTITY CASCADE")
      end
      puts "Database emptied."
    end
  end
  