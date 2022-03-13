FROM ruby:3.1.1
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
########################################################################
# yarnパッケージ管理ツールをインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn
# Node.jsをインストール
# https://deb.nodesource.com/setup_current.xだとwebpackerのcompileが失敗するためバージョンを下げる
# see https://penpen-dev.com/blog/error-error0308010cdigital-envelope-routinesunsupported%E3%81%AA%E3%82%A8%E3%83%A9%E3%83%BC/
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt install -y nodejs

#######################################################################

RUN mkdir /toy_app
WORKDIR /toy_app
COPY Gemfile /toy_app/Gemfile
COPY Gemfile.lock /toy_app/Gemfile.lock
RUN bundle install
COPY . /toy_app

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

RUN curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]

