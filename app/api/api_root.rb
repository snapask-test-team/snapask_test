class ApiRoot < Grape::API
  PREFIX = '/api'.freeze

  format :json

  include Errors::ExceptionHandlers

  mount V1::Base
end