ARG RUBY_VERSION

FROM europe-central2-docker.pkg.dev/petr-radous/ruby/$RUBY_VERSION:development AS BUILD

COPY ./Gemfile* /root
RUN bundle config --local without "development test" \
  && bundle config --local path "/vendor/bundle" \
  && bundle install

COPY . /root
RUN npm i -g yarn \
  && bundle exec yarn install \
  && RAILS_ENV=production EXECJS_RUNTIME=Node bundle exec rails assets:precompile \
  && rm -rf /root/node_modules

FROM europe-central2-docker.pkg.dev/petr-radous/ruby/$RUBY_VERSION:production
EXPOSE 3000

COPY --from=BUILD /root /root
COPY --from=BUILD /vendor/bundle /vendor/bundle

RUN bundle config --local without "development test" \
  && bundle config --local path "/vendor/bundle" \
  && bundle config --local deployment "true"

RUN apt-get update && apt-get install -y libvips \
  && rm -rf /var/lib/apt/lists/*

CMD bundle exec rails db:create \
  && bundle exec rails db:migrate \
  && bundle exec bin/rails s -b 0.0.0.0
