# FayeBackgrounder

FayeBackgrounder makes it easy to publish updates to the client from your backgound workers using Faye pubsub server. 

## Installation

Add this line to your application's Gemfile:

    gem 'faye_backgrounder'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install faye_backgrounder

## Usage

Using FayeBackgrounder requires [Faye](http://faye.jcoglan.com/) to be installed and configured. It is highly recommended that an extension is setup for security as well for Faye.

FayeBackgrounder reads the secret_token for Faye under `FAYE_TOKEN` if your token is named something else just create an initializer to set the token.

```ruby
# config/initializers/faye_backgrounder_token.rb
FAYE_TOKEN = ORIGINAL_TOKEN
```

Use the view helper to add subscriptions to your views. Subscriptions are made by providing a channel type and the ID of the resource or a unique ID like the `current_user` ID. This will help to prevent any cross contamination of different channels. For example given a view for a `user` resource:

```ruby
# app/views/users/show.html.erb
<%= subscribe_to("users", current_user.id) %>

<% #... Normal view code here %>
```

You can then add a publish method to your background worker to publish to the view. 

Example using Resque:

```ruby
# app/jobs/some_background_task.rb
class SomeBackgroundJob
  @queue = :some_queue

  def self.perform
    new.process
  end

  def process
    # ... Do some work

    FayeBackgrounder.publish_to("users", user.id) do
      # This is some javascript you want to publish to faye to render your new content
      # you can send plain text or render partials using the `render` method
      <<-EOS
        $("#some-element-on-the-client").before("#{
          FayeBackgrounder.render("users/show", { :feature => feature })
        }").remove();
      EOS
    end
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
