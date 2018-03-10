# frozen_string_literal: true

Hertz::Twilio.configure do |config|
  # Your Twilio phone number.
  config.phone_number = '+390123456789'

  # Your Twilio account's SID.
  config.account_sid = 'YourTwilioAccountSid'

  # Your Twilio authentication token
  config.auth_token = 'YourTwilioAuthToken'
end
