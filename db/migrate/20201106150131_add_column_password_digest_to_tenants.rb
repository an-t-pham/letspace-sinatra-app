class AddColumnPasswordDigestToTenants < ActiveRecord::Migration
  def change
    add_column :tenants, :password_digest, :string
  end
end
