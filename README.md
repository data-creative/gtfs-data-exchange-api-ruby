# GTFS::DataExchange

A ruby wrapper for the [gtfs-data-exchange.com api](http://www.gtfs-data-exchange.com/api). Exposes `agency` and `agencies` endpoints.

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

Response data is returned in JSON format by default. To return data in CSV format instead, pass the `:format` option ...

```` rb
agencies = GTFS::DataExchange::API.agencies(:format => "csv")
````

### Agency

Find an agency by its `dataexchange_id`.

```` rb
agency = GTFS::DataExchange::API.agency(:dataexchange_id => "shore-line-east")
````

## Contributing

1. Fork it ( https://github.com/databyday/gtfs-data_exchange/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
