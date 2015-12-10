require 'fake_twilio'

# Emulate the minimal phone number lookup API
# Note that a real ISO country code is NOT returned.
get '/v1/PhoneNumbers/:number' do
  {
    'country_code': 'XX',
    'phone_number': params['number'],
    'national_format': params['number']
  }.to_json
end
