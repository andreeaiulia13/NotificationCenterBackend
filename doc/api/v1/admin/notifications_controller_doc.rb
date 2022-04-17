# frozen_string_literal: true

module Api::V1::Admin::NotificationsControllerDoc
  extend Apipie::DSL::Concern

  api :POST, '/v1/admin/notifications', 'Create a notification for clients'
  param_group :authorization, Api::V1::ApipieDefinitions
  param :title, String, required: true
  param :description, String, required: true
  param :emails, String, required: true
  def create; end

  api :GET, '/v1/admin/notifications/read_notifications', 'Shows all the read notifications from the latest read to the oldest.'
  param_group :authorization, Api::V1::ApipieDefinitions
  def read_notifications; end

  api :GET, '/v1/admin/notifications/unread_notifications', 'Shows all the unread notifications from the latest sent to the oldest.'
  param_group :authorization, Api::V1::ApipieDefinitions
  def unread_notifications; end
end 
