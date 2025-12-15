class ApartmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_apartment, only: [:show, :edit, :update, :destroy]
  before_action :authorize_host!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @apartments = Apartment.all
  end

  def show
  end

  def new
    @apartment = current_user.apartments.build
  end

  def create
    @apartment = current_user.apartments.build(apartment_params)
    if @apartment.save
      redirect_to @apartment, notice: "Apartment created successfully."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @apartment.update(apartment_params)
      redirect_to @apartment, notice: "Apartment updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @apartment.destroy
    redirect_to apartments_path, notice: "Apartment deleted."
  end

  private

  def set_apartment
    @apartment = Apartment.find(params[:id])
  end

  def apartment_params
    params.require(:apartment).permit(:title, :description, :guests, :address, :price, :host_id, :photo)
  end

  def authorize_host!
     redirect_to root_path, alert: "Access denied" unless current_user.role == "host"
  end
end
