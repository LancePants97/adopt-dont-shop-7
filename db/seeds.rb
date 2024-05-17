# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Shelter.destroy_all
Pet.destroy_all
VeterinaryOffice.destroy_all
Veterinarian.destroy_all
Application.destroy_all

# Shelter 1
hts = Shelter.create!(
                    foster_program: true,
                    name: "Happy Tails Shelter",
                    city: "Denver",
                    rank: 1
                    )

# Shelter 2
sfhva = Shelter.create!(
                    foster_program: false,
                    name: "Safe Haven Animal Rescue",
                    city: "Austin",
                    rank: 2
                    )

# Shelter 3
pcs = Shelter.create!(
                    foster_program: true,
                    name: "Paws and Claws Sanctuary",
                    city: "Seattle",
                    rank: 3
                    )

# Pet 1
pet1 = Pet.create!(
                adoptable: true,
                age: 3,
                breed: "Labrador",
                name: "Buddy",
                shelter_id: hts.id
                )

# Pet 2
pet2 = Pet.create!(
                adoptable: false,
                age: 7,
                breed: "Siamese",
                name: "Mittens",
                shelter_id: hts.id
                )

# Pet 3
pet3 = Pet.create!(
                adoptable: true,
                age: 2,
                breed: "Bulldog",
                name: "Rex",
                shelter_id: sfhva.id
                )

# Pet 4
pet4 = Pet.create!(
                adoptable: false,
                age: 5,
                breed: "Beagle",
                name: "Luna",
                shelter_id: sfhva.id
                )

# Pet 5
pet5 = Pet.create!(
                adoptable: true,
                age: 4,
                breed: "Persian",
                name: "Simba",
                shelter_id: sfhva.id
                )

# Pet 6
pet6 = Pet.create!(
                    adoptable: true,
                    age: 6,
                    breed: "Poodle",
                    name: "Charlie",
                    shelter_id: pcs.id
                    )



# Veterinary Office 1
vet_office1 = VeterinaryOffice.create!(
                                        boarding_services: true,
                                        max_patient_capacity: 50,
                                        name: "Green Valley Vet Clinic"
                                        )

# Veterinary Office 2
vet_office2 = VeterinaryOffice.create!(
                                        boarding_services: false,
                                        max_patient_capacity: 30,
                                        name: "Downtown Animal Hospital"
                                        )

# Veterinary Office 3
vet_office3 = VeterinaryOffice.create!(
                                        boarding_services: true,
                                        max_patient_capacity: 40,
                                        name: "Hillside Veterinary Services"
                                        )
# Application number 1                       

# Veterinarian 1
vet1 = Veterinarian.create!(
                            on_call: true,
                            review_rating: 5,
                            name: "Dr. Sarah Brown",
                            veterinary_office_id: vet_office1.id
                            )

# Veterinarian 2
vet2 = Veterinarian.create!(
                            on_call: false,
                            review_rating: 4,
                            name: "Dr. Michael Smith",
                            veterinary_office_id: vet_office1.id
                            )

# Veterinarian 3
vet3 = Veterinarian.create!(
                            on_call: true,
                            review_rating: 5,
                            name: "Dr. Emily Johnson",
                            veterinary_office_id: vet_office2.id
                            )

# Veterinarian 4
vet4 = Veterinarian.create!(
                            on_call: false,
                            review_rating: 3,
                            name: "Dr. David Lee",
                            veterinary_office_id: vet_office2.id
                            )

# Veterinarian 5
vet5 = Veterinarian.create!(
                            on_call: true,
                            review_rating: 4,
                            name: "Dr. Jennifer Wilson",
                            veterinary_office_id: vet_office3.id
                            )

# Veterinarian 6
vet6 = Veterinarian.create!(
                            on_call: false,
                            review_rating: 5,
                            name: "Dr. James Martinez",
                            veterinary_office_id: vet_office3.id
                            )

app1 = Application.create!(applicant_name: 'John Doe', street_address: '123 Main St', city: 'Denver', state: 'CO', zip_code: '80202')

# Application number 2
app2 = Application.create!(applicant_name: 'Jane Smith', street_address: '456 Elm St', city: 'Boulder', state: 'CO', zip_code: '80301')

# Associate pets with applications
ApplicationPet.create!(application: app1, pet: pet1)
ApplicationPet.create!(application: app1, pet: pet2)
ApplicationPet.create!(application: app2, pet: pet2)