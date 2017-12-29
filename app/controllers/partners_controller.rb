class PartnersController < ApplicationController

  def show
    @partner = referential.find_partner params[:id]
  end

  def new
    @partner = Edwig::Partner.new referential
  end

  def create
    @partner = referential.create_partner prepare_settings(params[:partner])

    if @partner.valid?
      redirect_to referential_path(referential.id), flash: {notice: t("partners.flash_messages.valid")}
    else
      flash[:error] = t("partners.flash_messages.invalid")
      render :new
    end
  end

  def edit
    @partner = referential.find_partner params[:id]
  end

  def update
    @partner = referential.find_partner params[:id]

    @partner.attributes = prepare_settings(params[:partner])

    if @partner.save
      redirect_to referential_path(referential.id), flash: {notice: t("partners.flash_messages.valid")}
    else
      flash[:error] = t("partners.flash_messages.invalid")
      render :edit
    end
  end

  def referential
    @referential ||= edwig_server.find_referential params[:referential_id]
  end

  def destroy
    partner = referential.find_partner params[:id]
    partner.destroy
    redirect_to referential_path(referential.id)
  end

  def db_save
    response = referential.save_partners
    if response
      flash[:error] = t('partners.flash_messages.db_save_error', error: response["error"])
    else
      flash[:notice] = t('partners.flash_messages.db_save_success')
    end
    redirect_to referential_path(referential.id)
  end

  private

  def prepare_settings(attributes)
    attributes[:settings] = Hash[(attributes[:settings]||[]).map { |k,v| v.values }]
    attributes
  end

end
