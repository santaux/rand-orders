require "bundler/gem_tasks"
require 'yard'
require './spec/db/db_creator'

# Generates documentation:
YARD::Rake::YardocTask.new

# RSpec executing:
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

namespace :test do
  desc "Create database and table for specs"
  namespace :db do
    task :migrate do
      adapter_name = ENV['ADAPTER'] || 'sqlite'
      db_creator = DBCreator.new(adapter_name)
      db_creator.migrate
    end
  end
end