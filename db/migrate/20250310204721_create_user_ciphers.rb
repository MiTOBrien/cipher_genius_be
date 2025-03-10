class CreateUserCiphers < ActiveRecord::Migration[7.1]
  def change
    create_table :user_ciphers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :cipher, null: false, foreign_key: true
      t.integer :solved_time

      t.timestamps
    end
  end
end
