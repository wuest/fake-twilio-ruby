require 'fake_twilio'

# Emulate the Messages API, reporting the delivered SMS via stdout and
# optionally writing message info to a file.
get "/#{FakeTwilio::API_VERSION}/Accounts/:account_sid/IncomingPhoneNumbers.?:format" do
  numbers = (0..9).map { |num| "+1555555555#{num}" }
  {
    'incoming_phone_numbers': numbers.map do |num|
      {
        'sid' => num.delete('+'),
        'account_sid' => params[:account_sid],
        'phone_number' => num,
        'capabilities' => { 'voice' => true, "sms": true, "mms": true }
      }
    end
  }.to_json
end
