# frozen_string_literal: true

require 'twilio-ruby'
require 'hertz'

require 'hertz/twilio/engine'
require 'hertz/twilio/version'

module Hertz
  module Twilio
    mattr_accessor :phone_number, :account_sid, :auth_token

    class << self
      def configure
        yield(self)
      end

      def deliver_notification(notification)
        Hertz::Twilio::NotificationDeliveryJob.perform_later(notification)
      end
    end
  end
end
