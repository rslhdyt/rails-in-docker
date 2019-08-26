FROM ruby:2.6.2

RUN apt-get update -qq && \
    apt-get install -y build-essential

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for capybara-webkit
# RUN apt-get install -y libqt4-webkit libqt4-dev xvfb

RUN gem install rails bundler

# for JS runtime
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -qq -y nodejs yarn

ENV APP_HOME /home/app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY . $APP_HOME

RUN bundle install
RUN rails webpacker:install
