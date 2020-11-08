class DropColumnCurrentPropertyIdToTenants < ActiveRecord::Migration
  def change
    remove_column :tenants, :current_property_id
  end
end
