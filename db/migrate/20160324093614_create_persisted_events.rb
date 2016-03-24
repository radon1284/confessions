class CreatePersistedEvents < ActiveRecord::Migration
  def change
    create_table :persisted_events do |t|
      t.string :event_type, null: false
      t.string :visitor_identifier, index: true
      t.json :payload

      t.timestamps null: false
    end
  end
end
