require 'spec_helper'

module GTFSDataExchangeAPI
  describe "#agencies" do
    it 'lists all agencies' do
      agencies_response = [
        {
          "date_last_updated"=>1354248333.0,
          "feed_baseurl"=>"",
          "name"=>"A. Reich GmbH Busbetrieb",
          "area"=>"",
          "url"=>"http://www.vbb.de",
          "country"=>"",
          "state"=>"",
          "license_url"=>"",
          "dataexchange_url"=>"http://www.gtfs-data-exchange.com/agency/a-reich-gmbh-busbetrieb/",
          "date_added"=>1354248333.0,
          "is_official"=>false,
          "dataexchange_id"=>"a-reich-gmbh-busbetrieb"
        },
        {
          "date_last_updated"=>1417658131.0,
          "feed_baseurl"=>"http://data.cabq.gov/transit/gtfs/google_transit.zip",
          "name"=>"ABQ Ride",
          "area"=>"Albuquerque",
          "url"=>"http://myabqride.com",
          "country"=>"United States",
          "state"=>"New Mexico",
          "license_url"=>"",
          "dataexchange_url"=>"http://www.gtfs-data-exchange.com/agency/abq-ride/",
          "date_added"=>1340739867.0,
          "is_official"=>true,
          "dataexchange_id"=>"abq-ride"
        }
      ]
      parsed_agencies_response = agencies_response.map{|a| Hash[a.map{|k,v| [k.to_sym, (v == "" ? nil : v)]}]}
      expect(parsed_agencies_response).to be_kind_of(Array)
      expect(parsed_agencies_response.first).to be_kind_of(Hash)
      expect(parsed_agencies_response.first[:dataexchange_id]).to be_kind_of(String)
      expect(parsed_agencies_response.first[:feed_baseurl]).to be(nil)
    end

    it 'lists all agencies in CSV format' do
      agencies = GTFSDataExchangeAPI.agencies(:format => "csv")
      expect(agencies).to be_kind_of(String)
      csv_result = CSV.parse(agencies, :headers => true)
      expect(csv_result.headers).to include("dataexchange_id")
      expect(csv_result.first).to be_kind_of(CSV::Row)
      expect(csv_result.first.to_hash["dataexchange_id"]).to be_kind_of(String)
    end

    it 'explains why it is unable to return agencies data in an unsupported format' do
      unsupported_format = "sql"
      expect{ GTFSDataExchangeAPI.agencies(:format => unsupported_format) }.to raise_error
    end
  end

  describe '#agency' do
    it 'finds a specific agency by its data exchange identifier' do
      requested_identifier = "metro-north-railroad"
      agency_response = {
        "date_last_updated"=>1394241933.0,
         "feed_baseurl"=>"http://www.mta.info/developers/",
         "name"=>"Metro North Railroad",
         "area"=>"",
         "url"=>" http://www.mta.info/mnr/index.html",
         "country"=>"United States",
         "state"=>"New York",
         "license_url"=>"",
         "dataexchange_url"=>"http://www.gtfs-data-exchange.com/agency/metro-north-railroad/",
         "date_added"=>1263414635.0,
         "is_official"=>true,
         "dataexchange_id"=>"metro-north-railroad"
      }
      parsed_agency_response = Hash[agency_response.map{|k,v| [k.to_sym, (v == "" ? nil : v)]}]
      expect(parsed_agency_response).to be_kind_of(Hash)
      expect(parsed_agency_response[:dataexchange_id]).to eql(requested_identifier)
      expect(parsed_agency_response[:area]).to be(nil)
    end

    it 'explains why it is unable to find an unrecognized agency' do
      unrecognized_identifier = "my-railroad"
      expect{ GTFSDataExchangeAPI.agency(:dataexchange_id => unrecognized_identifier) }.to raise_error
    end
  end
end
