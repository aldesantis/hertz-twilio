# frozen_string_literal: true
module Hertz
  module Courier
    module Twilio
      class NotificationDeliveryJob < ActiveJob::Base
        queue_as :default

        def perform(notification)
          return unless notification.receiver.hertz_phone_number.present?

          twilio_client.messages.create(
            to: notification.receiver.hertz_phone_number,
            from: Hertz::Courier::Twilio.phone_number,
            body: notification.sms_body
          )
        end

        private

        def twilio_client
          @twilio_client ||= ::Twilio::REST::Client.new(
            Hertz::Courier::Twilio.account_sid,
            Hertz::Courier::Twilio.auth_token
          )
        end
      end
    end
  end
end
