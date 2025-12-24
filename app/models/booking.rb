class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :apartment
  has_one :payment, dependent: :destroy

  validates :start_date, :end_date, :status, presence: true
  validate :end_after_start

  before_validation :set_total_price

  private

  def end_after_start
    return if start_date.blank? || end_date.blank?

    if end_date <= start_date
      errors.add(:end_date, "must be after start date")
    end
  end

  def set_total_price
    return if start_date.blank? || end_date.blank?

    self.total_price = apartment.price * (end_date - start_date).to_i
  end
end
