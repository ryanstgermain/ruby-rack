require_relative 'api_key'
require_relative 'file_logger'
require_relative 'friendly_errors'
require_relative 'validate_content_type'
require_relative 'who_is_calling'

require_relative 'application_helpers'
require_relative 'users_application'
require_relative 'rides_application'

require_relative 'database'
database = Database.new

use Rack::Session::Cookie, secret: "shhhhhh"

require_relative "url_appender"
use UrlAppender

use Rack::Runtime
use Rack::ContentType, "application/json"
use Rack::ContentLength

use Rack::ETag
use Rack::ConditionalGet
use Rack::Deflater

if ENV["RACK_ENV"] == "production"
  use Rack::NullLogger
  use Rack::CommonLogger
else
  use Rack::NullLogger
  use Rack::Reloader
end

use ApiKey, database: database
use ValidateContentType
use Rack::ShowStatus
use FriendlyErrors

use WhoIsCalling

use Rack::Sendfile
use Rack::Static, urls: ["/docs"], root: "public"

map("/users") do
  run UsersApplication.new(database)
end

map("/rides") do
  run RidesApplication.new(database)
end

