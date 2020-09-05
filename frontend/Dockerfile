FROM ruby:2.7.1-alpine

RUN apk update && apk add bash build-base nodejs postgresql-dev tzdata yarn

WORKDIR /app

COPY . .

RUN gem install bundler --no-document
RUN bundle install --jobs $(nproc)
RUN yarn install

CMD rails server
