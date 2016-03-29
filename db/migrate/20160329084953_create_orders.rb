class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.timestamps null: false
    end
  end
end
