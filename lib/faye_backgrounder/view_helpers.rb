# lib/faye_backgrounder/view_helpers.rb
module FayeBackgrounder
  module ViewHelpers
    def subscribe_to(channel_type, id)
      javascript_tag do
        raw(
          <<-EOS
            // FayeBackgrounder subscription helper
            $(function() {
              // Initialize Faye client
              var faye = new Faye.Client("#{FayeBackgrounder.host}faye");
              // Subscribe to channel
              faye.subscribe("/#{FayeBackgrounder.obfuscate_channel(channel_type, id)}", function(data){
                eval(data);
              });
            });
          EOS
        )
      end
    end
  end
end