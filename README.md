# MultiMeet
<a href="https://codeclimate.com/github/Aakup/MultiMeet-1/maintainability"><img src="https://api.codeclimate.com/v1/badges/17147a80811321af3566/maintainability" /></a>

<a href="https://codeclimate.com/github/Aakup/MultiMeet-1/test_coverage"><img src="https://api.codeclimate.com/v1/badges/17147a80811321af3566/test_coverage" /></a>

<a href="https://travis-ci.org/Aakup/MultiMeet"><img src="https://travis-ci.org/Aakup/MultiMeet.svg?branch=master"></a>

<a href="http://multi-meet.herokuapp.com/"><img src="http://heroku-badge.herokuapp.com/?app=multi-meet&style=flat&svg=1"></a>

## Dependencies
- Ruby 2.4.0
- Rails 4.2.10

## Development Quickstart
1. clone repo: `git clone https://github.com/Aakup/MultiMeet`
2. `cd MultiMatch`
3. install packages: `bundle install --without production`
4. create and seed db: `db:setup` (runs `db:create db:schema:load db:seed`)
5. create a file `config/initializers/app_env_vars.rb` and enter your emailer acc and password:
```
ENV['MAILER_EMAIL'] = 'noreply@multimeet.com'
ENV['MAILER_PASSWORD'] = '<your password>'
```
7. `rails s(erver)` --> starts app on [http://localhost:3000](http://localhost:3000)

## Development Guidelines
- develop on your own branch of this repo, call it by your <name/feature> e.g. kevin/projects-list
- write your own tests for your own feature
- write down cucumber scenarios before coding
- before you push: make sure tests run via `bundle exec rspec` and `bundle exec cucumber features`
- push the branch, then PR to master, and wait for a code review
- in case of merge conflict: pull from master, resolve locally, push to your branch.

### DB migrations
- if making db changes:
  - run `db:migrate` and check in your new `schema.rb`
  - to completely overwrite schema and migrations: `rake db:drop db:create db:migrate db:seed`
- each time you pull and there's a migration: run `db:migrate` or `db:reset`
