#!/bin/sh
set -e

SERVER_TESTS=1 rake test

gem build fake-twilio.gemspec
docker build -t fake-twilio .
