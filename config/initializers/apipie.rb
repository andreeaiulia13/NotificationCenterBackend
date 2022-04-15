# frozen_string_literal: true

Apipie.configure do |config|
  config.app_name                = 'NotificationCenterAPI'
  config.api_base_url            = '/api'
  config.doc_base_url            = '/apipie'
  config.translate               = false
  config.validate                = :explicitly
  config.namespaced_resources    = true
  config.show_all_examples       = true
  config.api_controllers_matcher = Rails.root.join('app', 'controllers', 'api', 'v1', '**', '*.rb')
end
