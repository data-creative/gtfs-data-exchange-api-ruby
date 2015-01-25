# GTFS::DataExchange

A ruby wrapper for the [gtfs-data-exchange.com](http://www.gtfs-data-exchange.com) [api](http://www.gtfs-data-exchange.com/api). List all agencies, or find a specific agency by its data exchange identifier.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gtfs-data_exchange'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gtfs-data_exchange

## Usage

### Agencies

List all agencies.

```` rb
agencies = GTFS::DataExchange::API.agencies
````

By default, this will return an `Array` of Ruby `Hash` objects. Pass the 'csv' format option to return a CSV `String` instead.

```` rb
agencies = GTFS::DataExchange::API.agencies(:format => "csv")
````

### Agency

Find an agency by its data exchange identifier.

```` rb
agency = GTFS::DataExchange::API.agency(:dataexchange_id => "shore-line-east")
````

By default, this will return a Ruby `Hash` object.

## Contributing

1. Fork it ( https://github.com/data-creative/gtfs-data_exchange/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Test your changes (optional, but encouraged `rspec spec/`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request
