# Fake Twilio API
Emulate the Twilio API for faster local development.  At the present time the
scope is constrained to the minimum calls needed to test Canvas LMS locally.

## Getting started with the web service
### Running Locally
The `bin/fake-twilio-server` script will run a Sinatra application suitable for
local testing against the Twilio API.  The minimal effort method of getting up
and running is:

```
$ bundle install
$ bin/fake-twilio-server
```

### Running in Docker
A Dockerfile is provided, as well as a script to automatically build a Docker
image with the local copy of Fake Twilio.  To utilize the script:

```
$ ./build.sh
$ docker run -t fake-twilio
```

## Configuration
The Fake Twilio web service supports the following configuration options,
configured via environment variables:

* Address to which to bind (`LISTEN_IP`), defaults to 0.0.0.0 (all interfaces)
* Port on which to listen (`LISTEN_PORT`), defaults to 4444
* Which server to use (`HTTP_SERVER`), defaults to thin
* Whether to write files for e.g. integration testing, (`WRITE_OUTPUT`)

## Interacting with Fake-Twilio
The normal API client software can be used for interaction.  To configure the
ruby client to use the fake service, provide the following configuration to the
optional configuration hash to `Twilio::REST::Client` or
`Twilio::REST::LookupClient`: `{host:'localhost', port:'4444', use_ssl: false}`

This assumes that the service is running on port 4444 on the local host; adjust
the settings accordingly.
