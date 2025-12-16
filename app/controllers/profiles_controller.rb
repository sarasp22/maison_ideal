class ProfilesController < ApplicationController
  before_action :authenticate_user!

def show
  @user = current_user

  if @user.tenant?
    @bookings = @user.bookings.includes(:apartment)
  elsif @user.host?
    @apartments = @user.apartments
    @received_bookings = Booking.joins(:apartment)
                                .where(apartments: { host_id: @user.id })
                                .includes(:user, :apartment)
  end
end


  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to profile_path, notice: "Profile updated successfully"
    else
      reload_profile_data
      render :show, status: :unprocessable_entity
    end
  end

  private

  def load_tenant_data
    @bookings = @user.bookings
                     .includes(:apartment)
                     .order(created_at: :desc)
  end

  def load_host_data
    @apartments = @user.apartments

    @received_bookings = Booking
      .joins(:apartment)
      .where(apartments: { host_id: @user.id })
      .includes(:user, :apartment)
      .order(created_at: :desc)
  end

  def reload_profile_data
    @user.host? ? load_host_data : load_tenant_data
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
