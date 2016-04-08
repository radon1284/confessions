class CustomerSupportRequest < ActiveRecord::Base
  validates_presence_of :subject, :body, :email
end
