class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :apartment
  has_one :payment, dependent: :destroy

  validates :start_date, :end_date, :total_price, presence: true
  validates :status, inclusion: { in: %w[pending confirmed cancelled] }
  validate :end_date_after_start_date
  validate :start_date_cannot_be_in_the_past
  validate :dates_must_be_available

  before_validation :set_total_price

  scope :pending, -> { where(status: 'pending') }
  scope :confirmed, -> { where(status: 'confirmed') }
  scope :cancelled, -> { where(status: 'cancelled') }
  scope :upcoming, -> { where('start_date > ?', Date.today) }
  scope :past, -> { where('end_date < ?', Date.today) }
  scope :current, -> { where('start_date <= ? AND end_date >= ?', Date.today, Date.today) }

    def editable?
    status == 'pending' && start_date > Date.today
  end

  def cancellable?
    status == 'pending' && start_date > Date.today
  end

  def nights
    (end_date - start_date).to_i
  end

  def calculate_total_price
    nights * apartment.price
  end

  private

def set_total_price
  return if start_date.blank? || end_date.blank? || apartment.blank?

  num_nights = (end_date - start_date).to_i
  if num_nights > 0
    self.total_price = apartment.price * num_nights
  end
end

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date <= start_date
      errors.add(:end_date, "must be after the start date")
    end
  end

  def start_date_cannot_be_in_the_past
    return if start_date.blank?

    if start_date < Date.today
      errors.add(:start_date, "cannot be in the past")
    end
  end

def dates_must_be_available
  return if start_date.blank? || end_date.blank? || apartment.blank?

  overlapping_bookings = apartment.bookings
    .where(status: ['pending', 'confirmed'])
    .where.not(id: id)
    .where(
      'start_date < ? AND end_date > ?',
      end_date,
      start_date
    )

  if overlapping_bookings.exists?
    errors.add(:base, "The selected dates are not available.")
  end
end

end
