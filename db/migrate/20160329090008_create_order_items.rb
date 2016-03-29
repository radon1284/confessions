class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :product, index: true, foreign_key: true
      t.references :order, index: true, foreign_key: true, type: :uuid
      t.integer :price_in_cents
      t.string :currency

      t.timestamps null: false
    end
  end
end
