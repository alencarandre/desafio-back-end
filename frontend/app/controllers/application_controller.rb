require "application_responder"

class ApplicationController < ActionController::Base
  respond_to :html

  self.responder = ApplicationResponder
end
