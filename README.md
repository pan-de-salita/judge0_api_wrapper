
# Judge0 API Client Library

A Ruby module simplifying interactions with the Judge0 API, supporting operations such as fetching system statuses, listing supported languages, submitting code for evaluation, and querying submission details.

## Key Features

- **Status Management:** Operational status checks.
- **Language Support:** Listing available programming languages.
- **Submission Handling:** Code submission and retrieval of submission details.
- **Error Handling:** Checks for invalid inputs and missing parameters.

## Getting Started

Subscribe to Judge0's free Basic Plan on RapidAPI or host the API on your local machine. Detailed instructions can be found on [Judge0's website](https://ce.judge0.com/).

## Usage

### Fetching response statuses

```
Judge0.client.statuses
```

### Retrieving active languages

```Judge0.client.languages```

### Getting all languages, both active and archived

```Judge0.client.all_languages```

### Fetching details about a specific language

```Judge0.client.language(language_id: 72) # -> Returns details on Ruby 2.7.0```

### Submitting source code for evaluation

```Judge0.client.write_submission( source_code: "puts 'Hello from Ruby!'", language_id: 72, stdin: nil ) # -> Returns a submission_token```

### Reading submission details

```Judge0.client.read_submission( token: "submission_token_here", fields: [:source_code, :stdout, :stderr])```

## Contributing

Contributions are welcome! Please feel free to submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
