module Hertz
  module Courier
    module Twilio
      RSpec.describe NotificationDeliveryJob do
        subject { described_class.new }

        let(:notification) { build_stubbed(:test_notification) }

        let(:twilio_client) { instance_double('::Twilio::REST::Client') }
        let(:twilio_messages) { instance_spy('::Twilio::REST::Messages') }

        before(:all) do
          class ::Twilio::REST::Client
            def messages; end
          end
        end

        before(:each) do
          allow(::Twilio::REST::Client).to receive(:new)
            .and_return(twilio_client)

          allow(twilio_client).to receive(:messages)
            .and_return(twilio_messages)
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
      end
    end
  end
end
