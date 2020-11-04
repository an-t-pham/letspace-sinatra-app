class AddColumnCurrentPropertyIdToTenants < ActiveRecord::Migration
  def change
    add_column :tenants, :current_property_id, :integer
  end
end
