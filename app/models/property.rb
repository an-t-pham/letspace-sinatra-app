class Property < ActiveRecord::Base
    belongs_to :landlord
    has_many :property_tenants
    has_many :tenants, through: :property_tenants
end
