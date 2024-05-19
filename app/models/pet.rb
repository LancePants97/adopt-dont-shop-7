class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.search(search)
    where('name ILIKE ? OR breed ILIKE ?', "%#{search}%", "%#{search}%")

    # if search
    #   dog_details = Pet.find_by(name: search)
    #   if dog_details
    #     self.where(pet_id: dog_details)
    #   else
    #     @pet = Pet.all
    #   end
    # else
    #   @pet = Pet.all
    # end
  end
end
