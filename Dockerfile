FROM ruby:2.7.1

WORKDIR /workspace

COPY Gemfile Gemfile.lock ./

RUN bundle install
