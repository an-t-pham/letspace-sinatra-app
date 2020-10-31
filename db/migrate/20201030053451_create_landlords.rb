class CreateLandlords < ActiveRecord::Migration
  def change
    create_table :landlords do |t|
      t.string :name
      t.text :profile
      t.string :image_url
      t.string :email
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
