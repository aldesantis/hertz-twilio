# frozen_string_literal: true
require 'twilio-ruby'
require 'hertz'

require 'hertz/courier/twilio/engine'
require 'hertz/courier/twilio/version'

module Hertz
  module Courier
    module Twilio
      mattr_accessor :phone_number, :account_sid, :auth_token

      class << self
        def configure
          yield(self)
        end

        def deliver_notification(notification)
          NotificationDeliveryJob.perform_later(notification)
        end
      end
    end
  end
end
