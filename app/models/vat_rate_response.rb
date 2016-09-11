class VATRateResponse < ApplicationRecord
  validates_presence_of :date, :payload
end
