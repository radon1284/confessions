class AddCountryFromStripeToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :country_from_stripe, :string
  end
end
