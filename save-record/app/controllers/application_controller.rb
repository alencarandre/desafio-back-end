class ApplicationController < ActionController::API
  before_action :default_format_json

  def default_format_json
    request.format = :json
  end
end
