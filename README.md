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
rake db:migrate
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