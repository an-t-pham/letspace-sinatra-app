class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :name
      t.text :profile
      t.string :image_url

      t.timestamps null: false
    end
  end
end
