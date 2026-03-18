# frozen_string_literal: true

class ApplicationService
  Response = Struct.new(:success?, :payload, :error, keyword_init: true) do
    def failure?
      !success?
    end
  end

  def self.call(*args, **kwargs)
    new.call(*args, **kwargs)
  end

  private

  def success(payload = nil)
    Response.new(success?: true, payload: payload)
  end

  def failure(error)
    Response.new(success?: false, error: error)
  end
end
