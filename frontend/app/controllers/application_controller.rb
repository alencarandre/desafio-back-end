require "application_responder"

class ApplicationController < ActionController::Base
  respond_to :html

  self.responder = ApplicationResponder

  skip_before_action :verify_authenticity_token
end
