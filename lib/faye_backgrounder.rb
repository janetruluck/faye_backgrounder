require "faye_backgrounder/version"
require "faye_backgrounder/railtie" if defined?(Rails)
require "net/http"

module FayeBackgrounder
  class << self
    include ActionView::Helpers::JavaScriptHelper
    # .publish_to
    # Publish content to faye server
    def publish_to(channel_type, id, &block)
      # determine channel
      channel = "/#{obfuscate_channel(channel_type, id)}"

      message = {
        channel:  channel,
        data:     block.yield,
        ext:      { auth_token: token }
      }

      uri = URI.parse("#{host}faye")

      Net::HTTP.post_form(uri, message: message.to_json)
    end

    # .render
    # Render partials outside of controllers
    def render(partial, args = {})
      # TODO Find another way to do this, it will not work with _url methods
      controller = ActionView::TestCase::TestController.new
      escape_javascript(controller.render_to_string(partial: partial, locals: args ))
    end

    # .host
    # Return the host from the rails app
    def host
      Rails.application.routes.url_helpers.root_url(port: 9292)
    end

    # .obfuscate_channel
    # obfuscates the channel that faye communicates on
    def obfuscate_channel(channel_type, id)
      # If a FAYE_TOKEN does not exist then use the rails app secret to secure the channel
      if FAYE_TOKEN
        Digest::SHA2.hexdigest([channel_type, id, token].join)
      else
        raise "No secret token set for Faye"
      end
    end

    private
    def token
      FAYE_TOKEN || Rails.application.config.secret
    end
  end
end
