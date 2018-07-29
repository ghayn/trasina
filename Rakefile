# rubocop:disable Airbnb/RiskyActiverecordInvocation

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new :specs do |task|
  task.pattern = Dir['spec/**/*_spec.rb']
end

desc "start trasina server"
task :server do |args|
  system %(puma -C config/puma.rb)
end
task :s => :server

desc "start trasina console"
task :console do |args|
  system %(./bin/console)
end
task :c => :console

namespace :db do
  desc "create database"
  task :create do |task, args|
    require 'sequel'
    target_database_name = "#{ENV['POSTGRES_DATABASE_BASE_NAME']}_#{ENV["RACK_ENV"]}"
    begin
      Sequel.connect(
        adapter: :postgres,
        user: ENV["POSTGRES_USER"],
        password: ENV["POSTGRES_PASSWORD"],
        host: ENV["POSTGRES_HOST"],
        port: ENV["POSTGRES_PORT"]
      ) do |db|
        puts "creating #{target_database_name}"
        db.execute "CREATE DATABASE #{target_database_name}"
      end
    rescue Sequel::DatabaseError => e
      if e.wrapped_exception.class != PG::DuplicateDatabase
        raise e
      end
      puts "already exists #{target_database_name}"
    end
  end

  desc "drop database"
  task :drop do |task, args|
    require 'sequel'
    Sequel.connect(
      adapter: :postgres,
      user: ENV["POSTGRES_USER"],
      password: ENV["POSTGRES_PASSWORD"],
      host: 'db',
      port: ENV["POSTGRES_PORT"]
    ) do |db|
      database = "#{ENV['POSTGRES_DATABASE_BASE_NAME']}_#{ENV["RACK_ENV"]}"
      puts "droping #{database}"
      db.execute "DROP DATABASE IF EXISTS #{database}"
    end
  end
end

task :default => ['specs']

# rubocop:enable Airbnb/RiskyActiverecordInvocation
