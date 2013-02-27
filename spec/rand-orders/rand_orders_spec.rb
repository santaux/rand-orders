require "spec_helper"
require 'fixtures/item'
require 'db/db_creator'

describe Rand::Orders do
  %w[sqlite postgresql mysql].each do |adapter|
    context adapter do
      before(:all) do
        @db_creator = DBCreator.new adapter
        @db_creator.establish_connection
      end

      before(:each) do
        Item.delete_all

        @items = []
        5.times { @items << Item.make! }
        stub(Item).random { Item.all }
      end

      it "should return some records" do
        Item.random.should_not be_blank
      end

      it "should return 5 records" do
        Item.random.size.should be_equal(5)
      end
    end
  end
end