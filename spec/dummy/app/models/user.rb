class User < ActiveRecord::Base
  include Hertz::Notifiable

  def hertz_phone_number
    phone_number
  end
end
