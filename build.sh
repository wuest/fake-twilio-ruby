#!/bin/sh
set -e

gem build fake-twilio.gemspec
docker build -t fake-twilio .
