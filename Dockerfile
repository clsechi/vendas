FROM ruby:2.3

RUN apt-get update
RUN apt-get install nodejs -y

EXPOSE 3000
ENV PORT 3000

RUN mkdir -p /var/www/vendas
WORKDIR /var/www/vendas

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

ADD . /var/www/vendas
CMD 'bundle exec rails server -b 0.0.0.0'
