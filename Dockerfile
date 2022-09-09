ARG RUBY_VERSION=3.1.2
FROM ruby:${RUBY_VERSION}-alpine as base

WORKDIR /app

ENV BUNDLE_PATH=vendor/bundle
ENV BUNDLE_WITHOUT=development:test
ENV BUNDLE_CLEAN=true

FROM base as gems

RUN apk add build-base postgresql-dev

COPY .ruby-version .
COPY Gemfile* .

RUN --mount=type=cache,target=/tmp/bundle \
  BUNDLE_PATH=/tmp/bundle bundle install && \
  mkdir vendor && cp -ar /tmp/bundle vendor/bundle

RUN rm -rf vendor/bundle/ruby/*/cache

FROM base

# libc6-compat required by nokogiri aarch64-linux
# libpq required by pg
# tzdata required by tzinfo
RUN apk add libc6-compat libpq tzdata

COPY --from=gems /app /app
COPY . .

RUN bundle exec rails assets:precompile
