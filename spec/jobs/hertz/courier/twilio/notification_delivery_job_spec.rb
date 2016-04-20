# frozen_string_literal: true
module Hertz
  module Courier
    module Twilio
      RSpec.describe NotificationDeliveryJob do
        before(:all) do
          # rubocop:disable Style/ClassAndModuleChildren
          class ::Twilio::REST::Client
            def messages; end
          end
          # rubocop:enable Style/ClassAndModuleChildren
        end

        let(:twilio_client) { instance_double('::Twilio::REST::Client') }
        let(:twilio_messages) { instance_spy('::Twilio::REST::Messages') }

        before(:each) do
          allow(::Twilio::REST::Client).to receive(:new)
            .and_return(twilio_client)

          allow(twilio_client).to receive(:messages)
            .and_return(twilio_messages)
        end

        let(:notification) { build_stubbed(:test_notification) }

        subject { described_class.new }

        context 'when the receiver has a phone number' do
          it 'delivers the notification by SMS' do
            subject.perform(notification)

            expect(twilio_messages).to have_received(:create)
              .with(a_hash_including(
                to: notification.receiver.phone_number,
                from: Hertz::Courier::Twilio.phone_number,
                body: notification.sms_body
              ))
          end
        end

        context 'when the receiver does not have a phone number' do
          before(:each) do
            allow(notification.receiver).to receive(:hertz_phone_number)
              .and_return(false)
          end

          it 'does not deliver the notification' do
            subject.perform(notification)
            expect(twilio_messages).not_to have_received(:create)
          end
        end
      end
    end
  end
end
