require 'fake_twilio'

# Emulate the Incoming Phone Numbers API, reporting 10 fake numbers per page
# for 10 pages, and no numbers beyond that.
get "/#{FakeTwilio::API_VERSION}/Accounts/:account_sid/IncomingPhoneNumbers/?:page?.?:format" do
  page    = params[:page].to_i
  numbers = page >= 0 && page <= 9 ? (0..9).map { |num| "+155555555#{page}#{num}" } : []
  uri     = "/#{FakeTwilio::API_VERSION}/Accounts/#{params[:account_sid]}/IncomingPhoneNumbers/%d.#{params[:format]}"
  {
    'next_page_uri': format(uri, page + 1),
    'previous_page_uri': format(uri, page - 1),
    'first_page_uri': format(uri, 0),
    'last_page_uri': format(uri, 9),
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
