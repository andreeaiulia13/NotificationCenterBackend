# frozen_string_literal: true

module Api::V1::SessionsControllerDoc
  extend Apipie::DSL::Concern

  api :GET, '/v1/sessions', 'Get current user'
  param_group :authorization, Api::V1::ApipieDefinitions
  def index; end

  api :POST, '/v1/sessions', 'Login user'
  param :email, String, required: true
  param :password, String, required: true
  def create; end

  api :DELETE, '/v1/sessions', 'Logout user'
  param_group :authorization, Api::V1::ApipieDefinitions
  def destroy; end
end 
