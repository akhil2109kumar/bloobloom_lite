# Bloobloom Lite

Bloobloom Lite is a Rails application designed to manage the inventory of frames and lenses. It includes user authentication, admin roles, and RESTful APIs for managing frames, lenses, and glasses.

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Setup](#setup)
- [Running the Application](#running-the-application)
- [Testing](#testing)
- [Postman Collection](#postman-collection)
- [Contributing](#contributing)
- [License](#license)

## Requirements

- Ruby 3.2.2
- Rails ~> 7.0.8
- PostgreSQL
- Other dependencies are listed in the `Gemfile`.

## Installation

#1. Clone the repository:

```bash
git clone https://github.com/akhil2109kumar/bloobloom_lite.git
cd bloobloom_lite
```

#2. Install dependencies:

```bash
bundle install
```

#3. Set up the database:

```bash
rails db:create
rails db:migrate
```

#4. Seed the database with initial data:

```bash
rails db:seed
```

## Setup

#1. Copy the environment configuration file:

```bash
cp .env.example .env
```

#2. Update `.env` with the required configuration such as database credentials.

## Running the Application

To start the server, run:

```bash
rails server
```

This will start the server at [http://localhost:3000](http://localhost:3000).

## Testing

Run the tests using RSpec:

```bash
rspec
```

## Postman Collection

The Postman collection for the APIs can be found in the `postman_collection` directory of the repository.

1. Import the collection into Postman.
2. Set up the appropriate environment variables.
3. Start testing the APIs.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any changes or enhancements.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
