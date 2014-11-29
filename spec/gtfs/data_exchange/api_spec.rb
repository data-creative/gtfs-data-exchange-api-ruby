require 'spec_helper'
require 'pry'

module GTFS
  module DataExchange
    describe API do
      it 'lists all agencies' do
        agencies = GTFS::DataExchange::API.agencies
        expect(agencies).to be_kind_of(Array)
        expect(agencies.first).to be_kind_of(Hash)
        expect(agencies.first["dataexchange_id"]).to be_kind_of(String)
      end

      it 'finds a specific agency by its data exchange identifier' do
        specified_identifier = "metro-north-railroad"
        agency = GTFS::DataExchange::API.agency(:dataexchange_id => specified_identifier)
        expect(agency).to be_kind_of(Hash)
        expect(agency["dataexchange_id"]).to eql(specified_identifier)
      end
    end
  end
end

