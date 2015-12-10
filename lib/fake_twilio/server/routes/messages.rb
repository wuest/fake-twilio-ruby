require 'fake_twilio'

# Emulate the Messages API, reporting the delivered SMS via stdout and
# optionally writing message info to a file.
post "/#{FakeTwilio::API_VERSION}/Accounts/:account_sid/Messages.?:format" do
  message = FakeTwilio::Message.new(params)
  if message.success
    path = "sms_#{message.to.delete('+')}_#{Time.now.to_i}"
    write_file('sms', path, message.body)
    puts "Message delivered to #{message.to} on #{message.sent}"
  end

  message.to_json
end
