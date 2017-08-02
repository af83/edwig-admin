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
    @partner_slug = params[:slug]
    @partner_partner_status = params[:partner_status]
    @partner_connector_types = params[:connector_types]
  end

  def create
    attributes =
      {
        Slug: params[:partner_slug],
        PartnerStatus: params{:partner_status},
        ConnectorTypes: [params[:connector_types]],
        Settings: {params => :settings},
        Tokens: [params[:token]]
      }
    p "*" * 25
    p attributes
    create_partners = RestClient.post("#{Rails.configuration.edwig_api_host}/#{params[:referential_slug]}/partners", attributes.to_json, {content_type: :json, :Authorization => "Token token=#{params[:token]}"})
    redirect_to referential_partners_path
  end

  def destroy
    destroy_partners = RestClient.delete("#{Rails.configuration.edwig_api_host}/#{params[:slug]}/partners/#{params[:id]}", {content_type: :json, :Authorization => "Token token=#{params[:token]}"})
    redirect_to referential_partners_path(referential_slug: params[:slug], token: params[:token])
  end
end
