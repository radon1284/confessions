class AddSubscribedToMailingListToUser < ActiveRecord::Migration[5.0]
  def change
    add_column(
      :users,
      :subscribed_to_mailing_list,
      :boolean,
      null: false,
      default: false
    )
  end
end
