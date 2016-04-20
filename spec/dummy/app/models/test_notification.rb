class TestNotification < Hertz::Notification
  deliver_by :sms

  def sms_body
    'Test Notification'
  end
end
