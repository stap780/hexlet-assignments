# frozen_string_literal: true

require 'rack'

class Router
  def call(env)
    # BEGIN
    request = env['PATH_INFO'] # env is Rack hash object

    result = [404, { 'Content-Type' => 'text/plain' }, ['404 Not Found']]

    result = [200, { 'Content-Type' => 'text/plain' }, ['Hello, World!']] if request == '/'

    result = [200, { 'Content-Type' => 'text/plain' }, ['About page']] if request == '/about'

    result
    # END
  end
end
