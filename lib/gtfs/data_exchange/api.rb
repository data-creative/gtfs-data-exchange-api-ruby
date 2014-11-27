require "httparty"

module GTFS
  module DataExchange
    class API
      BASE_URL = "http://www.gtfs-data-exchange.com/api"

      def self.agencies(options = {})
        format = options[:format] || "json"
        raise UnsupportedRequestFormat, "The requested data format, '#{format}', is not supported by the service. Try 'csv' or 'json' instead." unless ["json","csv"].include?(format)

        request_url = "#{BASE_URL}/agencies?format=#{format}"
        response = HTTParty.get(request_url)

        case format
        when "json"
          raise ResponseCodeError unless response["status_code"] == 200
          raise ResponseDataError unless response["data"]
          return response["data"]
        when "csv"
          raise ResponseCodeError unless response.code == 200
          raise ResponseDataError unless response.body
          return response.body
        end
      end

      def self.agency(options = {})
        dataexchange_id = options[:dataexchange_id] || options[:data_exchange_id] || "shore-line-east"

        request_url = "#{BASE_URL}/agency?agency=#{dataexchange_id}"
        response = HTTParty.get(request_url)

        raise UnrecognizedDataExchangeId, "The requested dataexchange_id, '#{dataexchange_id}', was not recognized by the service." if response["status_code"] == 404 && response["status_txt"] == "AGENCY_NOT_FOUND"
        raise ResponseCodeError unless response["status_code"] == 200
        raise ResponseDataError unless response["data"]
        raise ResponseAgencyError unless response["data"]["agency"]
        return response["data"]["agency"]
      end

      # raised during an `API.agency` request when the requested `dataexchange_id` is unrecognized by the service
      class UnrecognizedDataExchangeId < ArgumentError ; end

      # raised during an `API.agencies` request when the requested data `format` is not supported by the service
      class UnsupportedRequestFormat < ArgumentError ; end

      # raised when an unexpected response code is returned from the service
      class ResponseCodeError < StandardError ; end

      # raised when unexpected or missing response data is returned from the service
      class ResponseDataError < StandardError ; end

      # raised when unexpected or missing agency data is returned from the service
      class ResponseAgencyError < StandardError ; end
    end
  end
end
