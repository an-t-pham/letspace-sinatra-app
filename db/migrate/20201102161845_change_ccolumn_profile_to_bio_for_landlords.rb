class ChangeCcolumnProfileToBioForLandlords < ActiveRecord::Migration
  def change
    rename_column :landlords, :profile, :bio
  end
end
