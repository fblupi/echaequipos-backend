# echaequipos-backend

[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Build Status](https://travis-ci.com/fblupi/echaequipos-backend.svg?branch=develop)](https://travis-ci.com/fblupi/echaequipos-backend)
[![Coverage Status](https://coveralls.io/repos/github/fblupi/echaequipos-backend/badge.svg)](https://coveralls.io/github/fblupi/echaequipos-backend)

EchaEquipos backend: API and admin panel build with Rails

## Running the application with Docker

### Setup

After [installing Docker](https://docs.docker.com/get-docker/), just run the commands below:

```bash
docker-compose build
docker-compose up -d
```

Then, open a console from the container and create the database:

```bash
docker exec -it echaequipos-backend_web_1 /bin/bash
rake db:create
rake db:migrate
rake db:seed
```

### Start and restart the application

```bash
docker-compose up
```

You can add th `-d` option to run in background

### Stop the application

```bash
docker-compose down
```

### Rebuild the application

Some changes require just `docker-compose up --build`, but a full rebuild require:

```bash
docker-compose run web bundle install
docker-compose up --build
```

### Tests

Just run the command below to run the unit tests:

```bash
rspec
```
