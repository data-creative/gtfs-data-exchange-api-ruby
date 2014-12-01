require "httparty"

# Top-level namespace referencing the General Transit Feed Specification (https://developers.google.com/transit/gtfs/).
module GTFS

  # Namespace referencing the data exchange (http://www.gtfs-data-exchange.com/), a third-party site "designed to help developers and transit agencies efficiently share and retrieve GTFS data."
  module DataExchange

    # Contains all data exchange api methods and exceptions.
    class API

      # The base url for api endpoints. This page also acts as the primary source for api reference documentation.
      BASE_URL = "http://www.gtfs-data-exchange.com/api"

      # List all agencies.
      # @param [Hash] options the request options.
      # @option options [String] :format ('json') the requested data format.
      # @raise [UnsupportedRequestFormat] if the requested data format is not supported by the service.
      # @raise [ResponseCodeError, ResponseDataError] for unexpected responses.
      # @return [Array, String] the agencies data in the requested format.
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

      # Find an agency by its data exchange identifier.
      # @param [Hash] options the request options.
      # @option options [String] :dataexchange_id ('shore-line-east') the requested agency identifier.
      # @raise [UnrecognizedDataExchangeId] if the requested agency identifier is unrecognized by the service.
      # @raise [ResponseCodeError, ResponseDataError, ResponseAgencyError] for unexpected responses.
      # @return [Hash] the agency data.
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

      # Exception raised if the service does not recognize the requested *dataexchange_id*.
      class UnrecognizedDataExchangeId < ArgumentError ; end

      # Exception raised if the service does not support the requested data format.
      class UnsupportedRequestFormat < ArgumentError ; end

      # Exception raised if the service returns an unexpected response code.
      class ResponseCodeError < StandardError ; end

      # Exception raised if the service returns unexpected or missing response data.
      class ResponseDataError < StandardError ; end

      # Exception raised if the service returns unexpected or missing agency data.
      class ResponseAgencyError < StandardError ; end
    end
  end
end
