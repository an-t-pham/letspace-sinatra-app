class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :address
      t.string :price
      t.text :description
      t.string :image_url
      t.integer :landlord_id

      t.timestamps null: false
    end
  end
end
