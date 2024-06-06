FROM ruby:2.7

WORKDIR /app

COPY Gemfile ./
RUN gem update --system 3.3.22
RUN bundle install

COPY . .

CMD ["ruby", "kafkaConsumer.rb"]
