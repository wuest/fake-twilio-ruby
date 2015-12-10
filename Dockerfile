FROM ruby:2.2

EXPOSE 4444

COPY fake-twilio-*.gem /app/fake-twilio.gem
COPY bin /app/bin
RUN \
  gem install /app/fake-twilio.gem && \
  mkdir -p /messages/sms && \
  useradd docker && \
  chown -R docker.docker /messages

USER docker

ENV PREFIX=/messages
CMD ["/app/bin/fake-twilio-server"]
