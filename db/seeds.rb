# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Pet.destroy_all
Shelter.destroy_all
Veterinarian.destroy_all
VeternaryOffice.destroy_all

# Pet 1
buddy = Pet.create!(
                adoptable: true,
                age: 3,
                breed: "Labrador",
                name: "Buddy",
                shelter_id: 1
                )

# Pet 2
mittens = Pet.create!(
                adoptable: false,
                age: 7,
                breed: "Siamese",
                name: "Mittens",
                shelter_id: 1
                )

# Pet 3
rex = Pet.create!(
                adoptable: true,
                age: 2,
                breed: "Bulldog",
                name: "Rex",
                shelter_id: 2
                )

# Pet 4
luna = Pet.create!(
                adoptable: false,
                age: 5,
                breed: "Beagle",
                name: "Luna",
                shelter_id: 2
                )

# Pet 5
simba = Pet.create!(
                adoptable: true,
                age: 4,
                breed: "Persian",
                name: "Simba",
                shelter_id: 2
                )

# Pet 6
charlie = Pet.create!(
                    adoptable: true,
                    age: 6,
                    breed: "Poodle",
                    name: "Charlie",
                    shelter_id: 3
                    )

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

# Veterinarian 1
vet1 = Veterinarian.create!(
                            on_call: true,
                            review_rating: 5,
                            name: "Dr. Sarah Brown",
                            veterinary_office_id: 1
                            )

# Veterinarian 2
vet2 = Veterinarian.create!(
                            on_call: false,
                            review_rating: 4,
                            name: "Dr. Michael Smith",
                            veterinary_office_id: 1
                            )

# Veterinarian 3
vet3 = Veterinarian.create!(
                            on_call: true,
                            review_rating: 5,
                            name: "Dr. Emily Johnson",
                            veterinary_office_id: 2
                            )

# Veterinarian 4
vet4 = Veterinarian.create!(
                            on_call: false,
                            review_rating: 3,
                            name: "Dr. David Lee",
                            veterinary_office_id: 2
                            )

# Veterinarian 5
vet5 = Veterinarian.create!(
                            on_call: true,
                            review_rating: 4,
                            name: "Dr. Jennifer Wilson",
                            veterinary_office_id: 3
                            )

# Veterinarian 6
vet6 = Veterinarian.create!(
                            on_call: false,
                            review_rating: 5,
                            name: "Dr. James Martinez",
                            veterinary_office_id: 3
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
