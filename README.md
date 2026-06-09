# fs-utility — Food-Services ordering & inventory system

A full-stack **Ruby on Rails** application built to run the food-services operations
of a large school district (Anaheim Union High School District): daily ordering,
production breakdowns, and monthly inventory across **44 campuses and a central
processing facility**, used on 250+ point-of-sale and desktop systems.

A real production system that replaced manual paper and spreadsheet workflows for
kitchen and warehouse staff. Published here as a work sample.

## Stack

- **Ruby on Rails** — ERB views, Bootstrap front-end
- **PostgreSQL** (ActiveRecord)
- **Devise** authentication + **Pundit** authorization
- **Thinking Sphinx** full-text search for fast indexed lookups
- **RSpec** specs under `spec/`

## Running locally

```sh
bundle install
rails db:setup
rails server
```

## Status

Archived. Built and maintained ~2014–2019. A few scratch files from the original
working tree remain.
