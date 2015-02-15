# GTFS DataExchange API

A ruby wrapper for the [gtfs-data-exchange.com](http://www.gtfs-data-exchange.com) [api](http://www.gtfs-data-exchange.com/api).

List all agencies, or find a specific agency by its data exchange identifier.

[![Gem Version](https://badge.fury.io/rb/gtfs_data_exchange_api.svg)](http://badge.fury.io/rb/gtfs-data_exchange)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gtfs_data_exchange_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gtfs_data_exchange_api

## Usage

### Agencies

List all agencies.

```` rb
agencies = GTFSDataExchangeAPI.agencies
````

By default, this will return an `Array` of Ruby `Hash` objects. Pass the 'csv' format option to return a CSV `String` instead.

```` rb
agencies = GTFSDataExchangeAPI.agencies(:format => "csv")
````

### Agency

Find an agency by its data exchange identifier.

```` rb
agency = GTFSDataExchangeAPI.agency(:dataexchange_id => "shore-line-east")
````

By default, this will return a Ruby `Hash` object.

## Contributing

1. [Fork the repo](https://github.com/data-creative/gtfs-data_exchange/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Test your changes (optional, but encouraged `rspec spec/`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request

## Releasing

> For instructions below, *X.X.X* refers to the gem version.

1. Build gem (`gem build gtfs_data_exchange_api.gemspec`)
2. Install gem locally (`gem install ./gtfs_data_exchange_api-X.X.X.gem`)
3. Run tests (`bundle exec rspec spec/`) 
4. Manually test, as desired:
  + `pry`
  + `require 'gtfs_data_exchange_api'`
  + test functionality
6. Create a new [release tag](https://github.com/data-creative/gtfs-data-exchange-api-ruby/releases/new)
7. Push gem build to rubygems (`gem push gtfs_data_exchange_api-X.X.X.gem`)
5. Merge version-named branch into master, if applicable


