class Application < ApplicationRecord
    has_many :application_pets
    has_many :pets, through: :application_pets
    validates :applicant_name, :street_address, :city, :state, :zip_code, :description, presence: true

    def approve
        update(status: 'Approved')
    end

    def reject
        update(status: 'Rejected')
    end

    def self.pending_apps
        
    end

end