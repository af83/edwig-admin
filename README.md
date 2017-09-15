# Edwig_admin

Ruby 2.2.6

## Installation

### Application

```
git clone git@github.com:af83/edwig-admin.git
cd edwig-admin
```

### Postgresql

```
CREATE USER "edwig_admin" SUPERUSER PASSWORD 'edwig_admin';
CREATE DATABASE "edwig_admin";
```

### Rails

```
bundle install
rails db:create
rails db:migrate
```

Seed to create the first user (the password will be displayed in the console)
```
rails db:seed
```

### Tests

```
rake db:migrate RAILS_ENV=test
rake spec
```

### For Production

```
export EDWIG_TOKEN="secret"

```

Database configuration can be defined in config/database.yml

## Running Edwig-admin

To run Edwig-admin, an Edwig server must be running. The server address can be configurated in environment config files with setting config.edwig_api_host.

The Edwig admin token must be set in an EDWIG_TOKEN environment variable. Il can be configurated in environment config files with setting config.edwig_token.
