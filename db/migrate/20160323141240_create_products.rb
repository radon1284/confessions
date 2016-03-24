class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :purchasable, index: true, polymorphic: true
      t.string :currency
      t.integer :price_in_cents

      t.timestamps null: false
    end
  end
end
