#
# This file is not autoloaded by default. Please enable this by including it as a shared
# module for all request specs in the RSpec configuration block (spec/rails_helper.rb).
#
# spec/support/request_spec_helper
#
module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end
end