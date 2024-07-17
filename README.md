# Judge0 API Client Library

A Ruby module simplifying interactions with the Judge0 API, supporting operations such as fetching system statuses, listing supported languages, submitting code for evaluation, and querying submission details.

## Key Features

- **Status Management:** Operational status checks.
- **Language Support:** Listing available programming languages.
- **Submission Handling:** Code submission and retrieval of submission details.
- **Error Handling:** Checks for invalid inputs and missing parameters.

## Getting Started

- Step 1: Clone the project.
- Step 2: Run `db:create` and `bundle install` as prerequisites.
- Step 3: Set up Judge0 authentication key in `.env`
Subscribe to Judge0's free Basic Plan on RapidAPI or host the API on your local machine*. After, set up `'X_RAPIDAPI_KEY'` with your authentication token in a `.env` file, i.e. `X_RAPIDAPI_KEY=your_authentication_token_here`.
- Step 4: Fire up Rails Console with `rails c`.

## Usage

### Fetching response statuses

```
Judge0.client.statuses
```

### Retrieving active languages

```
Judge0.client.languages
```

### Getting all languages, both active and archived

```
Judge0.client.all_languages
```

### Fetching details about a specific language

```
# Returns details on Ruby 2.7.0
Judge0.client.language(language_id: 72) 
```

### Submitting source code for evaluation

```
# Returns a submission_token
Judge0.client.write_submission( source_code: "puts 'Hello from Ruby!'", language_id: 72, stdin: nil ) 
```

### Reading submission details

```
Judge0.client.read_submission( token: "submission_token_here", fields: [:source_code, :stdout, :stderr])
```

## Contributing

Contributions are welcome! Please feel free to submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
