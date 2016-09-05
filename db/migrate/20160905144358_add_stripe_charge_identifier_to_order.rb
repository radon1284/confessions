class AddStripeChargeIdentifierToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :stripe_charge_identifier, :string
  end
end
