class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def edwig_server
    @edwig_server ||= Edwig::Server.new Rails.configuration.edwig_api_host, token: Rails.configuration.edwig_token, debug: true
  end

  def after_invite_path_for(inviter, invitee)
    users_path
  end

end
