require_relative 'api_key'
require_relative 'validate_content_type'
require_relative 'application_helpers'
require_relative 'users_application'
require_relative 'rides_application'
require_relative 'database'

use ApiKey
use ValidateContentType

map("/users") do
    run UsersApplication.new
end

map("/rides") do
    run RidesApplication.new
end

