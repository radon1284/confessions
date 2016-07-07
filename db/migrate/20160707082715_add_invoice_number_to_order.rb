class AddInvoiceNumberToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :invoice_number, :text
    add_index :orders, :invoice_number, unique: true
  end
end
