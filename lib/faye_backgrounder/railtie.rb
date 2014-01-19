# lib/faye_backgrounder/railtie.rb
# Railtie to hook into Rails ActionView helpers
require "faye_backgrounder/view_helpers"

module FayeBackgrounder
  class Railtie < Rails::Railtie
    initializer "faye_backgrounder.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end