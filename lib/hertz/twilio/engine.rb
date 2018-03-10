# frozen_string_literal: true

module Hertz
  module Twilio
    class Engine < ::Rails::Engine
      isolate_namespace Hertz::Twilio
    end
  end
end
