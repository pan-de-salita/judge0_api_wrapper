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
      'submissions_remaining' => 50,
      'data' => []
    }
  end

  describe '.statuses' do
    let(:statuses_data) do
      { 'data' => [
        { 'id' => 1, 'description' => 'In Queue' },
        { 'id' => 2, 'description' => 'Processing' },
        { 'id' => 3, 'description' => 'Accepted' }
      ] }
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
      expect(parsed_response_data['submissions_remaining']).to eq(50)
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
      expect(parsed_response_data['submissions_remaining']).to eq(50)
      expect(parsed_response_data['data']).to be_kind_of(Array)
      expect(parsed_response_data['data'].all? { |entry| entry.keys == %w[id name] }).to be_truthy
      expect(parsed_response_data['data'].first['name']).to eq('Assembly (NASM 2.14.02)')
    end
  end

  describe '.all_languages' do
    let(:all_languages_data) do
      { 'data' => [
        { 'id' => 45, 'name' => 'Assembly (NASM 2.14.02)', 'is_archived' => false },
        { 'id' => 2, 'name' => 'Bash (4.0)', 'is_archived' => true },
        { 'id' => 1, 'name' => 'Bash (4.4)', 'is_archived' => true }
      ] }
    end
    let(:all_languages_body) { base_body.merge(all_languages_data).to_json }

    it 'makes a GET request to /languages/all' do
      stub_request(:get, "#{base_url}/languages/all")
        .with(headers:)
        .to_return(status: 200, body: all_languages_body)

      response = Judge0::Client.all_languages
      parsed_response_data = JSON.parse(response[:data])

      expect(response[:status]).to eq(200)
      expect(parsed_response_data['reason_phrase']).to eq('OK')
      expect(parsed_response_data['submissions_remaining']).to eq(50)
      expect(parsed_response_data['data']).to be_kind_of(Array)
      expect(parsed_response_data['data'].all? { |entry| entry.keys == %w[id name is_archived] }).to be_truthy
      expect(parsed_response_data['data'].first['is_archived']).to eq(false)
    end
  end

  describe '.language' do
    let(:language_data) do
      { 'data' => {
        'id' => 72,
        'name' => 'Ruby (2.7.0)',
        'is_archived' => false,
        'source_file' => 'script.rb',
        'compile_cmd' => nil,
        'run_cmd' => '/usr/local/ruby-2.7.0/bin/ruby script.rb'
      } }
    end
    let(:language_body) { base_body.merge(language_data).to_json }

    it 'makes a GET request to /language/language_id' do
      stub_request(:get, "#{base_url}/languages/#{language_data['data']['id']}")
        .with(headers:)
        .to_return(status: 200, body: language_body)

      response = Judge0::Client.language(language_id: language_data['data']['id'])
      parsed_response_data = JSON.parse(response[:data])

      expect(response[:status]).to eq(200)
      expect(parsed_response_data['reason_phrase']).to eq('OK')
      expect(parsed_response_data['submissions_remaining']).to eq(50)
      expect(parsed_response_data['data']).to be_kind_of(Hash)
      expect(parsed_response_data['data'].keys).to eq(%w[id name is_archived source_file compile_cmd run_cmd])
      expect(parsed_response_data['data']['name']).to eq('Ruby (2.7.0)')
    end
  end

  ##############################################################################
  # Need actual API calls for the following?
  ##############################################################################

  describe '.write_submission' do
  end

  describe '.read_submission' do
  end
end
