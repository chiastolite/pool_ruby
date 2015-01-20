FROM chiastolite/docker-ruby

RUN apt-get install libsqlite3-dev; apt-get clean

WORKDIR /tmp
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock
RUN bundle install

ADD . /app
WORKDIR /app

RUN bundle exec rake db:migrate
EXPOSE 80
ENTRYPOINT ["bundle", "exec", "thin","start", "-p", "80"]
