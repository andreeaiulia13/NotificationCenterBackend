# frozen_string_literal: true

module Api::V1::ApipieDefinitions
  extend Apipie::DSL::Concern

  def_param_group :authorization do
    header 'Authorization', 'Bearer Token', required: true
    error code: 401, desc: 'Unauthorized'
  end

  def_param_group :errors do 
    error code: 404, desc: 'Not found'
    error code: 422, desc: 'Validation failed'
    error code: 500, desc: 'Internal server error'
  end
end
