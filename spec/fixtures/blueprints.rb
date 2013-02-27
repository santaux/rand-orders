require 'machinist/active_record'
require 'faker'
require './spec/fixtures/item'

Item.blueprint do
  name { Faker::Lorem.word }
end