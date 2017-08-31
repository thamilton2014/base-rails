# app/auth/authorize_api_request.rb
#
# This service gets the token from the authorization headers, attempts to decode it to return a valid user object. We
# also have a singleton 'Message' to house all our messages; this is an easier way to manage our application messages.
# We will define it in 'app/lib' since it's non-domain-specific.
#
class AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers
  end

  # Service entry point - return valid user object
  def call
    {
        user: user
    }
  end

  private

  attr_reader :headers

  def user
    # check if user is in the database
    # memoize user object
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
      # handle user not found
  rescue ActiveRecord::RecordNotFound => e
    # raise custom error
    raise(
        ExceptionHandler::InvalidToken,
        ("#{Message.invalid_token} #{e.message}")
    )
  end

  # decode authentication token
  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  # check for token in `Authorization` header
  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    # elsif headers['X-GitHub-Delivery'].present?
    #   return @request.query_parameters[:token]
    end
    raise(ExceptionHandler::MissingToken, Message.missing_token)
  end
end