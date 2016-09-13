class MakeUserEmailCaseInsensitive < ActiveRecord::Migration[5.0]
  def up
    enable_extension 'citext'
    change_column :users, :email, :citext, null: false
  end

  def down
    change_column :users, :email, :string, null: false
    disable_extension 'citext'
  end
end
