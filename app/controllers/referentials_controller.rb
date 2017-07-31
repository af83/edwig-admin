require 'rest-client'
require 'json'
class ReferentialsController < ApplicationController
  before_filter :authenticate_user!

  def index
    referentials = RestClient.get("#{Rails.configuration.edwig_api_host}/_referentials", {content_type: :json, :Authorization => "Token token=#{Rails.configuration.edwig_token}"})
    @referentials_tab = JSON.parse(referentials)
    @referentials_tab.sort_by! {|referential| referential["Slug"]}
  end

  def show

  end

  def partners

  end

  def new

  end

  def create

  end

  def edit
    @referential_id = params[:id]
    @referential_slug = params[:slug]
    @referential_nextreloadedat = params[:nextreloadedat]
    @referential_token = params[:token]
  end

  def update
    attributes =
    {
      Slug: params[:new_slug],
      NextReloadAt: params[:nextreloadedat],
      Tokens: [params[:token]]
    }
    edit_referentials = RestClient.put("#{Rails.configuration.edwig_api_host}/_referentials/#{params[:id]}", attributes.to_json, {content_type: :json, :Authorization => "Token token=#{Rails.configuration.edwig_token}"})
    redirect_to referentials_path
  end

  def destroy
    destroy_referentials = RestClient.delete("#{Rails.configuration.edwig_api_host}/_referentials/#{params[:slug]}", {content_type: :json, :Authorization => "Token token=#{Rails.configuration.edwig_token}"})
    redirect_to referentials_path
  end
end