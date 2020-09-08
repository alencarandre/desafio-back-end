FROM ruby:2.7.1-alpine

RUN apk update && apk add \
  bash \
  build-base \
  postgresql-dev \
  postgresql-client \
  tzdata \
  yarn \
  aws-cli \
  curl

WORKDIR /app

COPY . .

RUN gem install bundler --no-document
RUN bundle install --jobs $(nproc)

CMD bin/start
