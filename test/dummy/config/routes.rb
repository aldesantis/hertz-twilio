Rails.application.routes.draw do

  mount HertzCourierTwilio::Engine => "/hertz_courier_twilio"
end
