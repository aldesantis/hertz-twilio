# frozen_string_literal: true

Hertz::Twilio.configure do |config|
  # Your Twilio phone number.
  config.phone_number = '+390123456789'

  # Your Twilio account's SID.
  config.account_sid = 'YourTwilioAccountSid'

  # Your Twilio authentication token
  config.auth_token = 'YourTwilioAuthToken'

  # Optional: An alphanumeric sender ID that will appear instead of your phone number. Not setting
  # this will just use `config.phone_number`.
  config.sender_id = nil
end
