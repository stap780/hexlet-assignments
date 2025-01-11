# frozen_string_literal: true

require 'digest'

class Signature
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)

    # check respnse Array and convert to string
    body = response.respond_to?(:each) ? response.join : response.to_s

    # Create SHA-256
    hash_sha256 = Digest::SHA256.hexdigest(body)

    # Add hash to body
    new_response = [body + '\n' + hash_sha256]

    # return new response
    [status, headers, new_response]
  end
end
