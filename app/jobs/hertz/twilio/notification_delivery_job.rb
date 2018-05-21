# frozen_string_literal: true

module Hertz
  module Twilio
    class NotificationDeliveryJob < ActiveJob::Base
      queue_as :default

      def perform(notification)
        return unless notification.receiver.hertz_phone_number.present?
        return if notification.delivered_with?(:twilio)

        twilio_client.messages.create(
          to: notification.receiver.hertz_phone_number,
          from: Hertz::Twilio.sender_id || Hertz::Twilio.phone_number,
          body: notification.sms_body
        )

        notification.mark_delivered_with(:twilio)
      end

      private

      def twilio_client
        @twilio_client ||= ::Twilio::REST::Client.new(
          Hertz::Twilio.account_sid,
          Hertz::Twilio.auth_token
        )
      end
    end
  end
end
