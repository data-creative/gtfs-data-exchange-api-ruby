require 'spec_helper'
require 'pry'

module GTFS
  module DataExchange
    describe API do

      # Agencies

      it 'lists all agencies' do
        agencies = GTFS::DataExchange::API.agencies
        expect(agencies).to be_kind_of(Array)
        expect(agencies.first).to be_kind_of(Hash)
        expect(agencies.first["dataexchange_id"]).to be_kind_of(String)
      end

      it 'lists all agencies in CSV format' do
        agencies = GTFS::DataExchange::API.agencies(:format => "csv")
        expect(agencies).to be_kind_of(String)
        csv_result = CSV.parse(agencies, :headers => true)
        expect(csv_result.headers).to include("dataexchange_id")
        expect(csv_result.first).to be_kind_of(CSV::Row)
        expect(csv_result.first.to_hash["dataexchange_id"]).to be_kind_of(String)
      end

      it 'explains why it is unable to return agencies data in an unsupported format' do
        unsupported_format = "sql"
        expect{ GTFS::DataExchange::API.agencies(:format => unsupported_format) }.to raise_error
      end

      # Agency

      it 'finds a specific agency by its data exchange identifier' do
        specified_identifier = "metro-north-railroad"
        agency = GTFS::DataExchange::API.agency(:dataexchange_id => specified_identifier)
        expect(agency).to be_kind_of(Hash)
        expect(agency["dataexchange_id"]).to eql(specified_identifier)
      end

      it 'explains why it is unable to find an unrecognized agency' do
        unrecognized_identifier = "my-railroad"
        expect{ GTFS::DataExchange::API.agency(:dataexchange_id => unrecognized_identifier) }.to raise_error
      end
    end
  end
end

