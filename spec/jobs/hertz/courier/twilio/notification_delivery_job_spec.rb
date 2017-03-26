# frozen_string_literal: true

module Hertz
  module Courier
    module Twilio
      RSpec.describe NotificationDeliveryJob do
        subject { described_class.new }

        let(:twilio_client) { instance_double('::Twilio::REST::Client') }
        let(:twilio_messages) { instance_spy('::Twilio::REST::Messages') }
        let(:notification) { build_stubbed(:test_notification) }

        before do
          # rubocop:disable Style/ClassAndModuleChildren
          class ::Twilio::REST::Client
            def messages; end
          end
          # rubocop:enable Style/ClassAndModuleChildren

          allow(::Twilio::REST::Client).to receive(:new)
            .and_return(twilio_client)

          allow(twilio_client).to receive(:messages)
            .and_return(twilio_messages)

          allow(notification).to receive(:delivered_with?)
            .with(:twilio)
            .and_return(false)

          allow(notification).to receive(:mark_delivered_with)
            .with(:twilio)
        end

        it 'delivers the notification by SMS' do
          subject.perform(notification)

          expect(twilio_messages).to have_received(:create)
            .with(a_hash_including(
              to: notification.receiver.phone_number,
              from: Hertz::Courier::Twilio.phone_number,
              body: notification.sms_body
            ))
        end

        it 'marks the notification as delivered through Twilio' do
          expect(notification).to receive(:mark_delivered_with)
            .with(:twilio)
            .once

          subject.perform(notification)
        end

        context 'when the receiver does not have a phone number' do
          before do
            allow(notification.receiver).to receive(:hertz_phone_number)
              .and_return(false)
          end

          it 'does not deliver the notification' do
            subject.perform(notification)
            expect(twilio_messages).not_to have_received(:create)
          end
        end

        context 'when the notification was already delivered through Twilio' do
          before do
            allow(notification).to receive(:delivered_with?)
              .with(:twilio)
              .and_return(true)
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
