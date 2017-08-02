require 'partner'

class PartnersController < ApplicationController
  def index
    @referential_slug = params[:referential_slug]
    @referential_token = params[:token]
    partners = RestClient.get("#{Rails.configuration.edwig_api_host}/#{params[:referential_slug]}/partners", {content_type: :json, :Authorization => "Token token=#{params[:token]}"})
    @partners_tab = JSON.parse(partners)
  end

  def show

  end

  def new
    @partner = Partner.new(
      slug: params[:slug],
      settings_remote_url: params[:settings_remote_url],
      connector_types: params[:connector_types]
    )
  end

  def create
    attributes =
      {
        slug: params[:partner_slug],
        #PartnerStatus: {"OperationnalStatus" => params[:partner_status_operationnal_statusl], "ServiceStartedAt" => params[:partner_status_service_started_at]},
        connectorTypes: [params[:connector_types]],
        settings: {"remote_url" => params[:settings_remote_url], "remote_credential" => params[:settings_remote_credential], "local_credential" => params[:settings_local_credential], "remote_objectid_kind" => params[:settings_remote_objectid_kind]}
      }
    RestClient.post("#{Rails.configuration.edwig_api_host}/#{params[:referential_slug]}/partners", attributes.to_json, {content_type: :json, :Authorization => "Token token=#{params[:token]}"})
    redirect_to referential_partners_path(token: params[:token])
  end

  def destroy
    RestClient.delete("#{Rails.configuration.edwig_api_host}/#{params[:slug]}/partners/#{params[:id]}", {content_type: :json, :Authorization => "Token token=#{params[:token]}"})
    redirect_to referential_partners_path(referential_slug: params[:slug], token: params[:token])
  end
end
