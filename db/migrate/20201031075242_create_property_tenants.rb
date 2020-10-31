class CreatePropertyTenants < ActiveRecord::Migration
  def change
    create_table :property_tenants do |t|
      t.integer :property_id
      t.integer :tenant_id

      t.timestamps null: false
    end
  end
end
