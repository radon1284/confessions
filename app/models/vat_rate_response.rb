class VATRateResponse < ApplicationRecord
  validates :date, :payload, presence: true
end
