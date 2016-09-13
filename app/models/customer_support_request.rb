class CustomerSupportRequest < ActiveRecord::Base
  validates :subject, :body, :email, presence: true
end
