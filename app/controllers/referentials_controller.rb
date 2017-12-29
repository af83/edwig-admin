class ReferentialsController < ApplicationController
  before_action :authenticate_user!

  def index
    @referentials = edwig_server.referentials.sort_by!(&:slug)
  end

  def show
    @referential = edwig_server.find_referential params[:id]
    @partners = @referential.partners
  end

  def new
    @referential = Edwig::Referential.new(edwig_server)
  end

  def create
    @referential = edwig_server.create_referential params[:referential]

    if @referential.valid?
      redirect_to referentials_path, flash: {notice: t("referentials.flash_messages.valid")}
    else
      flash[:error] = t("referentials.flash_messages.invalid")
      render :new
    end
  end

  def edit
    @referential = edwig_server.find_referential params[:id]
  end

  def update
    @referential = edwig_server.find_referential params[:id]
    @referential.attributes = params[:referential]

    if @referential.save
      redirect_to referentials_path, flash: {notice: t("referentials.flash_messages.valid")}
    else
      flash[:error] = t("referentials.flash_messages.invalid")
      render :edit
    end
  end

  def db_save
    response = edwig_server.save_referentials
    if response
      flash[:error] = t('referentials.flash_messages.db_save_error', error: response["error"])
    else
      flash[:notice] = t('referentials.flash_messages.db_save_success')
    end
    redirect_to referentials_path
  end

  def destroy
    referential = edwig_server.find_referential params[:id]
    referential.destroy
    redirect_to referentials_path
  end
end
