FROM ruby:3.1.4-alpine as build

WORKDIR /opt/app/

RUN apk add --update --no-cache \
    build-base \
    bash

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .
