# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pagy::Method

  rescue_from StandardError, with: :internal_server_error
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found(exception)
    render_fail_response(exception.model.underscore, "not found", :not_found)
  end

  def record_invalid(exception)
    record = exception.record
    render_fail_response(record.model_name.element, record.errors.to_hash(true), :unprocessable_entity)
  end

  def parameter_missing(exception)
    render_fail_response(exception.param, [ "parameter is required" ], :bad_request)
  end

  def internal_server_error(exception)
    Rails.logger.error(exception.class)
    Rails.logger.error(exception.message)
    render_error_response(
      Rails.env.production? ? "Internal Server Error" : exception.message, :internal_server_error
    )
  end

  def render_fail_response(resource, message, status)
    render "shared/fail_response",
          locals: {
            resource: resource,
            message: message
          },
          status: status
  end

  def render_error_response(message, status)
    render "shared/error_response",
          locals: {
            message: message
          },
          status: status
  end
end
