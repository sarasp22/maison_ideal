class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :apartment
  has_one :payment, dependent: :destroy

  validates :start_date, :end_date, :total_price, :status, presence: true
  validate :end_after_start

  private

  def end_after_start
    return if end_date.blank? || start_date.blank?
    if end_date <= start_date
      errors.add(:end_date, "must be after start date")
    end
  end
end

