class CreateCiphers < ActiveRecord::Migration[8.0]
  def change
    create_table :ciphers do |t|
      t.string :cipher

      t.timestamps
    end
  end
end
