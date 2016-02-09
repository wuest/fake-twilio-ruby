require 'minitest/autorun'
require 'fake_twilio'
require 'twilio-ruby' if ENV['SERVER_TESTS']

$LOAD_PATH.unshift File.dirname(__FILE__)
