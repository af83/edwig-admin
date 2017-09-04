class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def edwig_server
    @edwig_server ||= Edwig::Server.new Rails.configuration.edwig_api_host, token: Rails.configuration.edwig_token, debug: true
  end

end
