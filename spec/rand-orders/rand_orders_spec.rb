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
        5.times { |i| @items << Item.make!(amount: i) }

        stub(Item).random { Item.all }
        stub(Item).random_in_range { Item.all[1..2] }
        stub(Item).random_equal { Item.all[1] }
      end

      context "random method" do
        it "should return 5 records" do
          Item.random.size.should be_equal(5)
        end
      end

      context "random_in_range method" do
        it "should return 2 records" do
          Item.random_in_range(:amount, (2..3)).size.should be_equal(2)
        end
      end

      context "random_equal method" do
        it "should return item with amount equal 1" do
          Item.random_equal(:amount, 1).amount.should be_equal(1)
        end
      end
    end
  end
end