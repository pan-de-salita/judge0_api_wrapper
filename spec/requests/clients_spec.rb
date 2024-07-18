# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Judge0::Client, type: :request do
  let(:base_url) { 'https://judge0-ce.p.rapidapi.com' }
  let(:headers) do
    {
      'Content-Type': 'application/json',
      'x-rapidapi-key': ENV['X_RAPIDAPI_KEY'],
      'x-rapidapi-host': 'judge0-ce.p.rapidapi.com'
    }
  end
  let(:base_body) do
    {
      'status' => 200,
      'reason_phrase' => 'OK',
      'data' => []
    }
  end

  describe '.statuses' do
    let(:statuses_data) do
      { 'data' => [{ 'id' => 1, 'description' => 'In Queue' },
                   { 'id' => 2, 'description' => 'Processing' },
                   { 'id' => 3, 'description' => 'Accepted' }] }
    end
    let(:statuses_body) { base_body.merge(statuses_data).to_json }

    it 'makes a GET request to /statuses' do
      stub_request(:get, "#{base_url}/statuses")
        .with(headers:)
        .to_return(status: 200, body: statuses_body)

      response = Judge0::Client.statuses
      parsed_response_data = JSON.parse(response[:data])

      expect(response[:status]).to eq(200)
      expect(parsed_response_data['reason_phrase']).to eq('OK')
      expect(parsed_response_data['data']).to be_kind_of(Array)
      expect(parsed_response_data['data'].all? { |entry| entry.keys == %w[id description] }).to be_truthy
      expect(parsed_response_data['data'].first['description']).to eq('In Queue')
    end
  end

  describe '.languages' do
    let(:languages_data) do
      { 'data' => [
        { 'id' => 45, 'name' => 'Assembly (NASM 2.14.02)' },
        { 'id' => 46, 'name' => 'Bash (5.0.0)' },
        { 'id' => 47, 'name' => 'Basic (FBC 1.07.1)' }
      ] }
    end
    let(:languages_body) { base_body.merge(languages_data).to_json }

    it 'makes a GET request to /languages' do
      stub_request(:get, "#{base_url}/languages")
        .with(headers:)
        .to_return(status: 200, body: languages_body)

      response = Judge0::Client.languages
      parsed_response_data = JSON.parse(response[:data])

      expect(response[:status]).to eq(200)
      expect(parsed_response_data['reason_phrase']).to eq('OK')
      expect(parsed_response_data['data']).to be_kind_of(Array)
      expect(parsed_response_data['data'].all? { |entry| entry.keys == %w[id name] }).to be_truthy
      expect(parsed_response_data['data'].first['name']).to eq('Assembly (NASM 2.14.02)')
    end
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
