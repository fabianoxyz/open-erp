#!/usr/bin/env bash
# exit on error
set -o errexit

bundle config set --local without 'development'

bundle install
yarn install

bundle exec rails assets:precompile
bundle exec rails assets:clean

bundle exec rails db:setup
bundle exec rails db:migrate
bundle exec rails db:seed