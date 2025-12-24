class ApartmentsController < ApplicationController
before_action :set_apartment, only: %i[edit update destroy]
before_action :authorize_host!, only: %i[new create]
before_action :authorize_owner!, only: %i[edit update destroy]

  def index
    @apartments = Apartment.all
  end

def show
  @apartment = Apartment.find(params[:id])
  @booking = Booking.new
end

  def new
    @apartment = current_user.apartments.build
  end

def create
  @apartment = Apartment.new(apartment_params)
  @apartment.host = current_user

  if @apartment.save
    redirect_to @apartment, notice: "Apartment created successfully."
  else
    render :new, status: :unprocessable_entity
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
  unless current_user.host?
    redirect_to apartments_path, alert: "Only hosts can create apartments."
  end
end

def authorize_owner!
  unless current_user.host? && current_user == @apartment.host
    redirect_to apartments_path, alert: "You are not authorized to edit this apartment."
  end
end

end
