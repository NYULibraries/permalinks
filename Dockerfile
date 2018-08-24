FROM ruby:2.5.1-alpine

ENV INSTALL_PATH /app
ENV BUILD_PACKAGES ruby-dev build-base linux-headers

RUN addgroup -g 1000 -S docker && \
  adduser -u 1000 -S -G docker docker

WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile.lock ./
RUN bundle config --global github.https true
RUN apk add --no-cache $BUILD_PACKAGES \
  && gem install bundler && bundle install --jobs 20 --retry 5 \
  && apk del $BUILD_PACKAGES \
  && chown -R docker:docker ./ \
  && chown -R docker:docker /usr/local/bundle

COPY --chown=docker:docker . .

USER docker

EXPOSE 9292

CMD ./scripts/start.sh arch
