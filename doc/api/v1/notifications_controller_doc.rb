# frozen_string_literal: true

module Api::V1::NotificationsControllerDoc
  extend Apipie::DSL::Concern

  api :GET, '/v1/notifications', 'Get all the notifications'
  param_group :authorization, Api::V1::ApipieDefinitions
  def index; end

	api :GET, '/v1/notifications/:id', 'Show the text of a notification'
  param_group :authorization, Api::V1::ApipieDefinitions
  param :id, Integer, required: true
  def show; end

  api :DELETE, '/v1/notifications/:id', 'Delete a notification'
  param_group :authorization, Api::V1::ApipieDefinitions
  param :id, Integer, required: true
  def destroy; end
end 
