# frozen_string_literal: true

module ResponseHandler
  extend ActiveSupport::Concern

  private

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
