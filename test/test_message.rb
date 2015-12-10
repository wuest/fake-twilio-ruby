require 'helper'

class TestMessage < ::MiniTest::Unit::TestCase
  def test_successful_initialization
    message = ::FakeTwilio::Message.new('To'   => '+15551234567',
                                        'Body' => 'Test')
    assert(message.success)
    assert_equal('+15551234567', message.to)
    assert_equal('Test', message.body)

    hash = JSON.parse(message.to_json)
    assert_equal(hash['price'], '0.03')
    assert_equal(hash['status'], 'sent')
    refute_nil(hash['datesent'])
  end

  def test_invalid_number
    message = ::FakeTwilio::Message.new('To'   => '15551234567',
                                        'Body' => 'Test')
    refute(message.success)

    hash = JSON.parse(message.to_json)
    assert_equal(hash['price'], '0.00')
    assert_equal(hash['status'], 'failed')
    assert_nil(hash['datesent'])
  end

  def test_no_number
    message = ::FakeTwilio::Message.new('To' => '', 'Body' => 'Test')
    refute(message.success)

    hash = JSON.parse(message.to_json)
    assert_equal(hash['price'], '0.00')
    assert_equal(hash['status'], 'failed')
    assert_nil(hash['datesent'])
  end

  def test_no_body
    message = ::FakeTwilio::Message.new('To' => '+15551234567', 'Body' => '')
    refute(message.success)

    hash = JSON.parse(message.to_json)
    assert_equal(hash['price'], '0.00')
    assert_equal(hash['status'], 'failed')
    assert_nil(hash['datesent'])
  end

  def test_body_too_long
    message = ::FakeTwilio::Message.new('To'   => '+15551234567',
                                        'Body' => 'A' * 1601)
    refute(message.success)

    hash = JSON.parse(message.to_json)
    assert_equal(hash['price'], '0.00')
    assert_equal(hash['status'], 'failed')
    assert_nil(hash['datesent'])
  end
end
