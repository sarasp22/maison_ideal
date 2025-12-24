class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_apartment, only: [:create]

  def create
    @booking = @apartment.bookings.new(booking_params)
    @booking.user = current_user
    @booking.total_price = @apartment.price * (@booking.end_date - @booking.start_date).to_i

    if @booking.save
redirect_to profile_path, notice: "Booking created successfully!"
    else
      render "apartments/show", status: :unprocessable_entity
    end
  end

  private

  def set_apartment
    @apartment = Apartment.find(params[:apartment_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
