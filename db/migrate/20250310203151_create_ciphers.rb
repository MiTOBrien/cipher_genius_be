class CreateCiphers < ActiveRecord::Migration[7.1]
  def change
    create_table :ciphers do |t|
      t.string :cipher_name

      t.timestamps
    end
  end
end
