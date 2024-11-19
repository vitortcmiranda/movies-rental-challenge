FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y nodejs

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler -v 2.3.26
RUN bundle install

COPY . .

RUN bundle exec rake assets:precompile

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]