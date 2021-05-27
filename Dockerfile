FROM ruby:2.6.7-alpine

WORKDIR /app
COPY . .

ENV BUNDLE_PATH=/bundle    \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"

RUN apk add --no-cache git
RUN gem install bundler:2.2.10
RUN bundle config set --local path 'vendor/bundle'
RUN bundle install --jobs=4 --retry=3
