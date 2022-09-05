FROM ruby:3.1.2-alpine
RUN apk add \
  build-base \
  postgresql-dev \
  tzdata \
  nodejs

COPY .ruby-version .
COPY Gemfile* ./
RUN bundle install
COPY . .

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]