class CreateVatRateResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :vat_rate_responses do |t|
      t.datetime :date
      t.json :payload

      t.timestamps
    end
  end
end
