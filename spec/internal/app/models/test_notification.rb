# frozen_string_literal: true

class TestNotification < Hertz::Notification
  deliver_by :twilio

  def sms_body
    'Test Notification'
  end
end
