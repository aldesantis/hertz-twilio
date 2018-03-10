# frozen_string_literal: true

RSpec.describe Hertz::Twilio do
  describe '.configure' do
    it 'changes the configuration options' do
      phone_number = '+390123456789'

      expect {
        described_class.configure do |config|
          config.phone_number = phone_number
        end
      }.to change(described_class, :phone_number).to(phone_number)
    end
  end

  describe '.deliver_notification' do
    let(:notification) { build_stubbed(:test_notification) }

    it 'schedules the delivery' do
      expect {
        described_class.deliver_notification(notification)
      }.to enqueue_a(described_class::NotificationDeliveryJob)
        .with(global_id(notification))
    end
  end
end
