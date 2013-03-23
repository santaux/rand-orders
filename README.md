# Rand::Orders

This gem provides several methods to fetch random records from database.
It is under construction at the moment.

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

    gem 'rand-orders'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rand-orders

## Usage

This chapter will be updated when work finished

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
