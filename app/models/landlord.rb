class Landlord < ActiveRecord::Base
    has_secure_password
    
    has_many :properties, dependent: :destroy
    has_many :tenants, through: :properties

    validates :name, :bio, :image_url, :email, presence: true
    validates_uniqueness_of :email
end