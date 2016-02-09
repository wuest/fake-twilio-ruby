require 'helper'

class TestIncomingNumbersList < ::MiniTest::Unit::TestCase
  def setup
    options = { host: 'localhost', port: 4444, use_ssl: false }
    @client = Twilio::REST::Client.new('ASDF', 'FDSA', options)
  end

  def test_pagination
    start_number = 15555555500
    end_number   = 15555555599

    list = @client.incoming_phone_numbers.list

    (0..9).reduce(list) do |list, page|
      numbers  = list.map(&:phone_number).map(&:to_i)
      expected = (start_number + (page * 10))..(start_number + (page * 10) + 9)
      assert_equal(numbers, expected.to_a)
      list.next_page
    end
  end

  def test_no_eleventh_page
    list = (0..9).reduce(@client.incoming_phone_numbers.list) { |a, _| a.next_page }
    assert_equal([], list.map(&:phone_number))
  end
end
