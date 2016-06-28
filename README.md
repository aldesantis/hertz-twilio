# Hertz::Courier::Twilio

[![Gem Version](https://badge.fury.io/rb/hertz-courier-twilio.svg)](https://badge.fury.io/rb/hertz-courier-twilio)
[![Dependency Status](https://gemnasium.com/badges/github.com/alessandro1997/hertz-courier-twilio.svg)](https://gemnasium.com/github.com/alessandro1997/hertz-courier-twilio)
[![Code Climate](https://codeclimate.com/github/alessandro1997/hertz-courier-twilio/badges/gpa.svg)](https://codeclimate.com/github/alessandro1997/hertz-courier-twilio)

This is a [Hertz](https://github.com/alessandro1997/hertz) courier for sending
notifications to your users via SMS by leveraging the
[Twilio](https://www.twilio.com) API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hertz-courier-twilio'
```

And then execute:

```console
$ bundle
```

Or install it yourself as:

```console
$ gem install hertz-courier-twilio
```

Then, run the installer generator:

```console
$ rails g hertz:courier:twilio:install
```

The courier will use ActiveJob to asynchronously deliver the text messages, so
make sure that you're executing background jobs with some adapter (`inline` will
work, even though it's not recommended). Jobs are pushed to the `default` queue.

Finally, you will have to expose a `#hertz_phone_number` method in your receiver
class:

```ruby
class User
  include Hertz::Notifiable

  def hertz_phone_number
    phone_number
  end
end
```

If `#hertz_phone_number` returns an empty value (i.e. `false`, `nil` or an empty
string) at the time the job is executed, the notification will not be delivered.
This allows you to programmatically enable/disable SMS notifications for a user:

```ruby
class User
  include Hertz::Notifiable

  def hertz_phone_number
    phone_number if phone_number_verified?
  end
end
```

## Usage

All you need to do in order to start delivering notifications by SMS is add
`twilio` to the notification's `deliver_by` statement and provide an SMS body:

```ruby
class CommentNotification < Hertz::Notification
  deliver_by :twilio

  def sms_body
    'You received a new comment!'
  end
end
```

All `CommentNotification`s will now be delivered by SMS! :)

**NOTE:** This courier uses the [deliveries API](https://github.com/alessandro1997/hertz#tracking-delivery-status)
to prevent double deliveries.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/alessandro1997/hertz-courier-twilio.

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

# To do

- [ ] Allow changing the job's queue
