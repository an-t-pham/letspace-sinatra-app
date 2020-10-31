class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :address
      t.integer :price
      t.text :description
      t.integer :landlord_id

      t.timestamps null: false
    end
  end
end
