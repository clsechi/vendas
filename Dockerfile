FROM ruby:2.3.3

RUN apt-get update -qq

RUN apt-get install -y --no-install-recommends nodejs

RUN mkdir -p /var/www/vendas

WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install --without test
RUN gem install bundler-audit

WORKDIR /var/www/vendas
ADD . /var/www/vendas
RUN cp config/sales.yml.sample config/sales.yml

run rake db:setup

EXPOSE 3000

CMD rails server --binding 0.0.0.0 --port 3000
