require 'yaml'
require 'rubygems'
require 'active_record'
require 'active_support/inflector'

class DBCreator

  attr_reader :adapter, :adapter_name

  def initialize(adapter_name)
    @adapter_name = adapter_name
    @adapter = "#{adapter_name.to_s}_adapter".camelize.constantize.new
  end

  def migrate
    @adapter.parse_config(@adapter_name)
    @adapter.create_db
    @adapter.establish_connection
    @adapter.create_tables
  end

  def establish_connection
    @adapter.parse_config(@adapter_name)
    @adapter.establish_connection
  end

  def connection
    @_connection ||= ActiveRecord::Base.connection
  end

  def table_exists?
    connection.table_exists? 'items'
  end
end

class DBAdapter

  attr_reader :config

  def parse_config(config_name)
    path = File.dirname(File.expand_path(__FILE__)) + "/#{config_name}.yml"
    @config = YAML::load(File.open(path))['test']
  end

  def establish_connection
    ActiveRecord::Base.establish_connection(@config)
  end

  def create_db
    raise "Do something with me. I'm abstract"
  end

  def create_tables
    ActiveRecord::Base.connection.create_table(:items, :force => true) do |t|
      t.string   "name"
      t.integer  "amount"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end

class MysqlAdapter < DBAdapter
  def create_db
    %x{mysql -e 'create database #{@config['database']};' -h localhost -u #{ENV['USERNAME'] || @config['username']} --password=#{ENV['PASSWORD'] || @config['password']}}
  end
end

class PostgresqlAdapter < DBAdapter
  def create_db
    %x{createdb --owner=#{ENV['USERNAME'] || @config['username']} #{@config['database']}}
  end
end

class SqliteAdapter < DBAdapter
  def create_db
    %x{touch ./#{@config['database']}.db}
  end
end
