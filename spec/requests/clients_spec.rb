# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Judge0::Client, type: :request do
  # Base URL for the Judge0 API
  let(:base_url) { 'https://judge0-ce.p.rapidapi.com' }

  # Headers including the API key and host
  let(:headers) do
    {
      'Content-Type': 'application/json',
      'x-rapidapi-key': ENV['X_RAPIDAPI_KEY'],
      'x-rapidapi-host': 'judge0-ce.p.rapidapi.com'
    }
  end

  # Default response body structure
  let(:base_body) do
    {
      'status' => 200,
      'reason_phrase' => 'OK',
      'submissions_remaining' => 50,
      'data' => []
    }
  end

  # Body for writing a new submission
  let(:write_submission_body) do
    {
      'source_code' => "def add(a, b)\n  p a + b\nend\n\nadd(5, 5)",
      'language_id' => 72
    }
  end

  describe '.statuses' do
    # Data representing the possible statuses returned by the API
    let(:statuses_data) do
      { 'data' => [
        { 'id' => 1, 'description' => 'In Queue' },
        { 'id' => 2, 'description' => 'Processing' },
        { 'id' => 3, 'description' => 'Accepted' }
      ] }
    end

    # Merged base body with statuses data, converted to JSON
    let(:statuses_body) { base_body.merge(statuses_data).to_json }

    it 'makes a GET request to /statuses' do
      # Stub the request to simulate a successful response
      stub_request(:get, "#{base_url}/statuses")
        .with(headers:)
        .to_return(status: 200, body: statuses_body)

      # Call the statuses method and parse the response
      response = Judge0::Client.statuses
      parsed_response_data = JSON.parse(response[:data])

      # Assert that the response has the expected properties
      expect(response[:status]).to eq(200)
      expect(parsed_response_data['reason_phrase']).to eq('OK')
      expect(parsed_response_data['submissions_remaining']).to eq(50)
      expect(parsed_response_data['data']).to be_kind_of(Array)
      expect(parsed_response_data['data'].all? { |entry| entry.keys == %w[id description] }).to be_truthy
      expect(parsed_response_data['data'].first['description']).to eq('In Queue')
    end
  end

  describe '.languages' do
    # Data representing the list of programming languages supported by the API
    let(:languages_data) do
      { 'data' => [
        { 'id' => 45, 'name' => 'Assembly (NASM 2.14.02)' },
        { 'id' => 46, 'name' => 'Bash (5.0.0)' },
        { 'id' => 47, 'name' => 'Basic (FBC 1.07.1)' }
      ] }
    end

    # Merged base body with languages data, converted to JSON
    let(:languages_body) { base_body.merge(languages_data).to_json }

    it 'makes a GET request to /languages' do
      # Stub the request to simulate a successful response
      stub_request(:get, "#{base_url}/languages")
        .with(headers:)
        .to_return(status: 200, body: languages_body)

      # Call the languages method and parse the response
      response = Judge0::Client.languages
      parsed_response_data = JSON.parse(response[:data])

      # Assert that the response has the expected properties
      expect(response[:status]).to eq(200)
      expect(parsed_response_data['reason_phrase']).to eq('OK')
      expect(parsed_response_data['submissions_remaining']).to eq(50)
      expect(parsed_response_data['data']).to be_kind_of(Array)
      expect(parsed_response_data['data'].all? { |entry| entry.keys == %w[id name] }).to be_truthy
      expect(parsed_response_data['data'].first['name']).to eq('Assembly (NASM 2.14.02)')
    end
  end

  describe '.all_languages' do
    # Data representing the complete list of programming languages, including archived ones
    let(:all_languages_data) do
      { 'data' => [
        { 'id' => 45, 'name' => 'Assembly (NASM 2.14.02)', 'is_archived' => false },
        { 'id' => 2, 'name' => 'Bash (4.0)', 'is_archived' => true },
        { 'id' => 1, 'name' => 'Bash (4.4)', 'is_archived' => true }
      ] }
    end

    # Merged base body with all languages data, converted to JSON
    let(:all_languages_body) { base_body.merge(all_languages_data).to_json }

    it 'makes a GET request to /languages/all' do
      # Stub the request to simulate a successful response
      stub_request(:get, "#{base_url}/languages/all")
        .with(headers:)
        .to_return(status: 200, body: all_languages_body)

      # Call the all_languages method and parse the response
      response = Judge0::Client.all_languages
      parsed_response_data = JSON.parse(response[:data])

      # Assert that the response has the expected properties
      expect(response[:status]).to eq(200)
      expect(parsed_response_data['reason_phrase']).to eq('OK')
      expect(parsed_response_data['submissions_remaining']).to eq(50)
      expect(parsed_response_data['data']).to be_kind_of(Array)
      expect(parsed_response_data['data'].all? { |entry| entry.keys == %w[id name is_archived] }).to be_truthy
      expect(parsed_response_data['data'].first['is_archived']).to eq(false)
    end
  end

  describe '.language' do
    # Data representing a single programming language
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

    # Merged base body with language data, converted to JSON
    let(:language_body) { base_body.merge(language_data).to_json }

    it 'makes a GET request to /language/language_id' do
      # Stub the request to simulate a successful response
      stub_request(:get, "#{base_url}/languages/#{language_data['data']['id']}")
        .with(headers:)
        .to_return(status: 200, body: language_body)

      # Call the language method and parse the response
      response = Judge0::Client.language(language_id: language_data['data']['id'])
      parsed_response_data = JSON.parse(response[:data])

      # Assert that the response has the expected properties
      expect(response[:status]).to eq(200)
      expect(parsed_response_data['reason_phrase']).to eq('OK')
      expect(parsed_response_data['submissions_remaining']).to eq(50)
      expect(parsed_response_data['data']).to be_kind_of(Hash)
      expect(parsed_response_data['data'].keys).to eq(%w[id name is_archived source_file compile_cmd run_cmd])
      expect(parsed_response_data['data']['name']).to eq('Ruby (2.7.0)')
    end
  end

  describe '.write_submission' do
    it 'makes a POST request to /submissions/?base64_encoded=false&wait=false' do
      # Use VCR cassette to record and replay the HTTP interaction
      VCR.use_cassette('judge0/client_write_submission') do
        # Make the submission and capture the response
        response = Judge0::Client.write_submission(
          source_code: write_submission_body['source_code'],
          language_id: write_submission_body['language_id']
        )

        # Assert that the submission was successful and check the response details
        expect(response[:status]).to be(201)
        expect(response[:reason_phrase]).to eq('Created')
        expect(response[:submissions_remaining] < 50).to be_truthy
        expect(response[:data]['token']).to_not be_blank
      end
    end
  end

  describe '.read_submission' do
    it 'makes a POST request to /submissions/submission_token?base64_encoded=false&fields=...' do
      # Use VCR cassette to record and replay the HTTP interaction
      VCR.use_cassette('judge0/client_read_submission') do
        # Retrieve the submission token from the previously recorded cassette
        write_submission_data = YAML.load_file('spec/cassettes/judge0/client_write_submission.yml')
        submission_token = JSON.parse(write_submission_data['http_interactions'].first['response']['body']['string'])['token']

        # Read the submission using the token and assert the response details
        response = Judge0::Client.read_submission(token: submission_token)

        expect(response[:status]).to be(200)
        expect(response[:reason_phrase]).to eq('OK')
        expect(response[:submissions_remaining] < 50).to be_truthy
        expect(response[:data]['source_code']).to eq(write_submission_body['source_code'])
        expect(response[:data]['language_id']).to eq(write_submission_body['language_id'])
        expect(response[:data]['stdout'].chomp.to_i).to eq(10)
      end
    end
  end
end
