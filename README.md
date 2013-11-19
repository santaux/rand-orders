# Rand::Orders

This gem provides several methods to fetch random records from database.

## Tests

To run tests, first, please create and fill with correct values these configuration files:

* ./spec/db/mysql.yml
* ./spec/db/postgresql.yml
* ./spec/db/sqlite.yml

You could find configuration examples into ./spec/db directory.
Then you need to create these databases by internal rake task for each database:

    ADAPTER=sqlite bundle exec rake test:db:migrate
    ADAPTER=postgresql bundle exec rake test:db:migrate
    ADAPTER=mysql bundle exec rake test:db:migrate

The you could run them and check that all is fine:

    $ rspec spec/

## Installation

Add this line to your application's Gemfile:

    gem 'rand-orders', :require => 'rand'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rand-orders

## Usage

```ruby
# It will work for any ActiveRecord inherited class:
( For example, this model has 'amount' integer field)
class Item < ActiveRecord::Base; end

# Require rand-orders gem by adding this string to any .rb file:
require 'rand'

# Let's get some records ordered randomly:
Item.random

# Or get some random records with field value between 2 and 5:
# (This is the same as: Item.where("amount > 2 AND amount < 5").random)
Item.random_in_range(:amount, (2..5)) #

# Also we can fetch from database only the fields equal to some value:
# (This is the same as: Item.where(:amount => 1).random)
Item.random_equal(:amount, 1)

# If we want to get values only from one of fields, use 'select_random' method:
# (This is the same as: Item.random.pluck(:amount))
Item.select_random(:amount)

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
