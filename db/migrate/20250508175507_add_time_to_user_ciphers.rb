class AddTimeToUserCiphers < ActiveRecord::Migration[8.0]
  def change
    add_column :user_ciphers, :won, :boolean
    rename_column :user_ciphers, :solved_time, :time
  end
end
