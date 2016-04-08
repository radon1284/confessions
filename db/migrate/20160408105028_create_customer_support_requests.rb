class CreateCustomerSupportRequests < ActiveRecord::Migration
  def change
    create_table :customer_support_requests do |t|
      t.text :subject
      t.text :body
      t.string :email

      t.timestamps null: false
    end
  end
end
