class CreateInvoiceRequests < ActiveRecord::Migration
  def change
    create_table :invoice_requests do |t|
      t.references :order, index: true, foreign_key: true, type: :uuid
      t.text :company_name
      t.text :address
      t.text :country
      t.text :vat_id

      t.timestamps null: false
    end
  end
end
