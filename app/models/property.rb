class Property < ActiveRecord::Base
    belongs_to :landlord
    has_many :property_tenants
    has_many :tenants, through: :property_tenants

    validates :address, :price, :description, :image_url, presence: true
end
