class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.integer :member_id, null: false
      t.string :address, null: false
      t.string :postal_code, null: false
      t.string :shipping_name, null: false

      t.timestamps
    end
  end
end
