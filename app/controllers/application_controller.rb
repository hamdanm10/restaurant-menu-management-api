# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ErrorHandler
  include Pagy::Method
end
