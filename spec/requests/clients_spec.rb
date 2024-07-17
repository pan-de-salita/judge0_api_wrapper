# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Judge0::Client, type: :request do
  before :all do
    @base_url = 'https://judge0-ce.p.rapidapi.com'
    @headers = {
      'Content-Type': 'application/json',
      'x-rapidapi-key': ENV['X_RAPIDAPI_KEY'],
      'x-rapidapi-host': 'judge0-ce.p.rapidapi.com'
    }
  end

  describe '.statuses' do
    let(:statuses_body) do
      {
        'status' => 200,
        'reason_phrase' => 'OK',
        'data' => [
          { 'id' => 1, 'description' => 'In Queue' },
          { 'id' => 2, 'description' => 'Processing' },
          { 'id' => 3, 'description' => 'Accepted' }
        ]
      }.to_json
    end

    it 'makes a GET request to /statuses' do
      stub_request(:get, "#{@base_url}/statuses")
        .with(headers: @headers)
        .to_return(status: 200, body: statuses_body)

      response = Judge0::Client.statuses
      expect(response[:status]).to eq(200)
      expect(JSON.parse(response[:data])['reason_phrase']).to eq('OK')
      expect(JSON.parse(response[:data])['data']).to be_kind_of(Array)
    end
  end

  describe '.languages' do
  end

  describe '.all_languages' do
  end

  describe '.language' do
  end

  ##############################################################################
  # Need actual API calls for the following?
  ##############################################################################

  describe '.write_submission' do
  end

  describe '.read_submission' do
  end
end
