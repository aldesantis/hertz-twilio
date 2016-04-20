# frozen_string_literal: true
module Hertz
  module Courier
    module Twilio
      class Engine < ::Rails::Engine
        isolate_namespace Hertz::Courier::Twilio
      end
    end
  end
end
