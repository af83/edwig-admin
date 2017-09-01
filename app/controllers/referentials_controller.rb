require 'rest-client'
require 'json'
require 'referential'

class ReferentialsController < ApplicationController
  before_action :authenticate_user!

  def index
    referentials = RestClient.get("#{Rails.configuration.edwig_api_host}/_referentials", {content_type: :json, :Authorization => "Token token=#{Rails.configuration.edwig_token}"})
    @referentials_tab = JSON.parse(referentials)
    @referentials_tab.sort_by! {|referential| referential["Slug"]}
  end

  def show
    @referential = Referential.new(
      id: params[:id],
      slug: params[:slug],
      next_reload_at: params[:next_reload_at],
      token: params[:token],
      partner: params[:partner]
    )
  end

  def new
    @referential = Referential.new(
      slug: params[:slug],
      token: params[:token]
    )
  end

  def create
    attributes ={
      Slug: params[:new_slug],
    }

    attributes[:Tokens] = [params[:token]] unless params[:token].blank?


    RestClient.post("#{Rails.configuration.edwig_api_host}/_referentials", attributes.to_json, {content_type: :json, :Authorization => "Token token=#{Rails.configuration.edwig_token}"})
    redirect_to referentials_path
  end

  def edit
    referential = RestClient.get("#{Rails.configuration.edwig_api_host}/_referentials/#{params[:id]}", {content_type: :json, :Authorization => "Token token=#{Rails.configuration.edwig_token}"})
    parsed_referential = JSON.parse(referential)

    @referential = Referential.new(
      id: parsed_referential["Id"],
      slug: parsed_referential["Slug"],
      next_reload_at: parsed_referential["NextReloadAt"],
      token: parsed_referential["Tokens"]
    )
  end

  def update
    attributes ={
      Slug: params[:new_slug],
      NextReloadAt: params[:next_reload_at],
    }
    attributes[:Tokens] = [params[:token]] unless params[:token].blank?

    RestClient.put("#{Rails.configuration.edwig_api_host}/_referentials/#{params[:id]}", attributes.to_json, {content_type: :json, :Authorization => "Token token=#{Rails.configuration.edwig_token}"})
    redirect_to referentials_path
  end

  def destroy
    RestClient.delete("#{Rails.configuration.edwig_api_host}/_referentials/#{params[:slug]}", {content_type: :json, :Authorization => "Token token=#{Rails.configuration.edwig_token}"})
    redirect_to referentials_path
  end
end
