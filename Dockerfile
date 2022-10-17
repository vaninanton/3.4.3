FROM ubuntu:latest
COPY ./ /app
WORKDIR /app
RUN apt-get update
RUN apt-get upgrade
RUN apt-get -y install libpq-dev imagemagick gsfonts ruby-full ssh supervisor
RUN gem install bundler
RUN curl -sL https://deb.nodesource.com/setup_9.x | sudo bash -
RUN apt-get install -y nodejs

RUN bundle install --without development test --path vendor/bundle
RUN rm -rf /usr/local/bundle/cache/*.gem 
RUN apt-get clean 
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
CMD [“/app/init.sh”]
