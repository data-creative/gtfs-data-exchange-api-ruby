module GTFS
  module DataExchange
    class API
      URL = "http://www.gtfs-data-exchange.com/api"

      def self.agencies(options = {})
        format = options[:format] || "json"
        raise RequestFormatError(format) unless ["json","csv"].include?(format)

        request_url = "#{URL}/agencies?format=#{format}"
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

        request_url = "#{URL}/agency?agency=#{dataexchange_id}"
        response = HTTParty.get(request_url)
        raise RequestDataExchangeIdError(dataexchange_id) if response["status_code"] == 404 && response["status_txt"] == "AGENCY_NOT_FOUND"
        raise ResponseCodeError unless response["status_code"] == 200
        raise ResponseDataError unless response["data"]
        raise ResponseAgencyError unless response["data"]["agency"]

        return response["data"]["agency"]
      end

      class RequestDataExchangeIdError < ArgumentError ; end
      class RequestFormatError < ArgumentError ; end

      class ResponseAgencyError < StandardError ; end
      class ResponseCodeError < StandardError ; end
      class ResponseDataError < StandardError ; end
    end
  end
end
