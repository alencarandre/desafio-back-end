FROM ruby:2.7.1-alpine

RUN apk update && apk add \
  bash \
  build-base \
  nodejs \
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
RUN yarn install

CMD bin/start
