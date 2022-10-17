FROM alpine:3.16.2

RUN apk add --no-cache \
        libpq-dev \
        imagemagick \
        ghostscript-fonts \
        nodejs \
        ruby-full \
        openssh \
        supervisor && \
    gem install bundler

WORKDIR /app
COPY Gemfile* /app

RUN bundle config --global silence_root_warning 1 && \
    bundle config set --local path 'vendor/bundle' && \
    bundle config set --local without 'development test' && \
    bundle install
COPY ./ /app


CMD ["sh", "/app/init.sh"]
