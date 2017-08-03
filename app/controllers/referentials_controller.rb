require 'rest-client'
require 'json'
require 'referential'
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
    @referential = Referential.new(
      slug: params[:slug],
      token: params[:token]
    )
  end

  def create
    attributes =
      {
        Slug: params[:new_slug],
        Tokens: [params[:token]]
      }
    RestClient.post("#{Rails.configuration.edwig_api_host}/_referentials", attributes.to_json, {content_type: :json, :Authorization => "Token token=#{Rails.configuration.edwig_token}"})
    redirect_to referentials_path
  end

  def edit
    @referential = Referential.new(
      id: params[:id],
      slug: params[:slug],
      next_reload_at: params[:next_reload_at],
      token: params[:token]
    )
  end

  def update
    attributes =
    {
      Slug: params[:new_slug],
      NextReloadAt: params[:next_reload_at],
      Tokens: [params[:token]]
    }
    RestClient.put("#{Rails.configuration.edwig_api_host}/_referentials/#{params[:id]}", attributes.to_json, {content_type: :json, :Authorization => "Token token=#{Rails.configuration.edwig_token}"})
    redirect_to referentials_path
  end

  def destroy
    RestClient.delete("#{Rails.configuration.edwig_api_host}/_referentials/#{params[:slug]}", {content_type: :json, :Authorization => "Token token=#{Rails.configuration.edwig_token}"})
    redirect_to referentials_path
  end
end