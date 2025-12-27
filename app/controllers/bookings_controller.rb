class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_apartment, only: [:create]
  before_action :set_booking, only: [:show, :edit, :update, :destroy, :accept, :reject]
  before_action :authorize_booking_participant!, only: [:show]
  before_action :authorize_tenant!, only: [:edit, :update, :destroy]
  before_action :authorize_host_of_booking!, only: [:accept, :reject]

def show
end

def create
  @booking = @apartment.bookings.new(booking_params)
  @booking.user = current_user
  @booking.status = 'pending'

  if @booking.save
    redirect_to profile_path, notice: "Booking created successfully!"
  else
    flash.now[:alert] = "Could not create booking: " + @booking.errors.full_messages.join(", ")
    render "apartments/show", status: :unprocessable_entity
  end
end


  def edit
    unless @booking.editable?
      redirect_to profile_path, alert: "This booking cannot be edited."
    end
  end

  def update
    unless @booking.editable?
      redirect_to profile_path, alert: "This booking cannot be edited."
      return
    end

    if @booking.update(booking_params)
      redirect_to profile_path, notice: "Booking updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @booking.status == "pending" && @booking.start_date > Date.today
      @booking.update(status: "cancelled")
      redirect_to profile_path, notice: "Booking cancelled successfully."
    else
      redirect_to profile_path, alert: "This booking cannot be cancelled."
    end
  end

  def accept
    if @booking.update(status: 'confirmed')
      redirect_to profile_path, notice: "Prenotazione confermata con successo!"
    else
      redirect_to profile_path, alert: "Impossibile confermare la prenotazione."
    end
  end

  def reject
    if @booking.update(status: 'rejected')
      redirect_to profile_path, notice: "Prenotazione rifiutata."
    else
      redirect_to profile_path, alert: "Impossibile rifiutare la prenotazione."
    end
  end

  private

  def set_apartment
    @apartment = Apartment.find(params[:apartment_id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def authorize_tenant!
    unless @booking.user == current_user
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  def authorize_booking_participant!
    unless @booking.user == current_user || @booking.apartment.host == current_user
      redirect_to root_path, alert: "You are not authorized to view this booking."
    end
  end

  def authorize_host_of_booking!
    unless current_user == @booking.apartment.host
      redirect_to profile_path, alert: "Non sei autorizzato a gestire questa prenotazione."
    end
  end
end
