class PartnersController < ApplicationController
  def index
    partners = RestClient.get("#{Rails.configuration.edwig_api_host}/#{params[:referential_slug]}/partners", {content_type: :json, :Authorization => "Token token=#{params[:token]}"})
    @partners_tab = JSON.parse(partners)
  end
end
