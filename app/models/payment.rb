class Payment < ApplicationRecord
  belongs_to :booking
  belongs_to :user

  validates :amount, :status, presence: true
  validates :status, inclusion: { in: %w[pending paid failed] }
end
