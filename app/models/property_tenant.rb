class PropertyTenant < ActiveRecord::Base
    belongs_to :property
    belongs_to :tenant
end