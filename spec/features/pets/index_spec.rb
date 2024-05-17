require "rails_helper"

RSpec.describe "the pets index" do
	before(:all) do
		# Shelter 1
	@hts = Shelter.create!(
							foster_program: true,
							name: "Happy Tails Shelter",
							city: "Denver",
							rank: 1
							)

	# Shelter 2
	@sfhva = Shelter.create!(
							foster_program: false,
							name: "Safe Haven Animal Rescue",
							city: "Austin",
							rank: 2
							)

	# Shelter 3
	@pcs = Shelter.create!(
							foster_program: true,
							name: "Paws and Claws Sanctuary",
							city: "Seattle",
							rank: 3
							)

	# Pet 1
	@pet1 = Pet.create!(
						adoptable: true,
						age: 3,
						breed: "Labrador",
						name: "Buddy",
						shelter_id: @hts.id
						)

	# Pet 2
	@pet2 = Pet.create!(
						adoptable: false,
						age: 7,
						breed: "Siamese",
						name: "Mittens",
						shelter_id: @hts.id
						)

	# Pet 3
	@pet3 = Pet.create!(
						adoptable: true,
						age: 2,
						breed: "Bulldog",
						name: "Rex",
						shelter_id: @sfhva.id
						)

	# Pet 4
	@pet4 = Pet.create!(
						adoptable: false,
						age: 5,
						breed: "Beagle",
						name: "Luna",
						shelter_id: @sfhva.id
						)

	# Pet 5
	@pet5 = Pet.create!(
						adoptable: true,
						age: 4,
						breed: "Persian",
						name: "Simba",
						shelter_id: @sfhva.id
						)

	# Pet 6
	@pet6 = Pet.create!(
						adoptable: true,
						age: 6,
						breed: "Poodle",
						name: "Charlie",
						shelter_id: @pcs.id
						)



	# Veterinary Office 1
	@vet_office1 = VeterinaryOffice.create!(
											boarding_services: true,
											max_patient_capacity: 50,
											name: "Green Valley Vet Clinic"
											)

	# Veterinary Office 2
	@vet_office2 = VeterinaryOffice.create!(
											boarding_services: false,
											max_patient_capacity: 30,
											name: "Downtown Animal Hospital"
											)

	# Veterinary Office 3
	@vet_office3 = VeterinaryOffice.create!(
											boarding_services: true,
											max_patient_capacity: 40,
											name: "Hillside Veterinary Services"
											)
	# Application number 1                       

	# Veterinarian 1
	@vet1 = Veterinarian.create!(
								on_call: true,
								review_rating: 5,
								name: "Dr. Sarah Brown",
								veterinary_office_id: @vet_office1.id
								)

	# Veterinarian 2
	@vet2 = Veterinarian.create!(
								on_call: false,
								review_rating: 4,
								name: "Dr. Michael Smith",
								veterinary_office_id: @vet_office1.id
								)

	# Veterinarian 3
	@vet3 = Veterinarian.create!(
								on_call: true,
								review_rating: 5,
								name: "Dr. Emily Johnson",
								veterinary_office_id: @vet_office2.id
								)

	# Veterinarian 4
	@vet4 = Veterinarian.create!(
								on_call: false,
								review_rating: 3,
								name: "Dr. David Lee",
								veterinary_office_id: @vet_office2.id
								)

	# Veterinarian 5
	@vet5 = Veterinarian.create!(
								on_call: true,
								review_rating: 4,
								name: "Dr. Jennifer Wilson",
								veterinary_office_id: @vet_office3.id
								)

	# Veterinarian 6
	@vet6 = Veterinarian.create!(
								on_call: false,
								review_rating: 5,
								name: "Dr. James Martinez",
								veterinary_office_id: @vet_office3.id
								)

	@app1 = Application.create!(applicant_name: 'John Doe', street_address: '123 Main St', city: 'Denver', state: 'CO', zip_code: '80202', description: "I have a big yard", status: "In Progress")

	# Application number 2
	@app2 = Application.create!(applicant_name: 'Jane Smith', street_address: '456 Elm St', city: 'Boulder', state: 'CO', zip_code: '80301', description: "I love animals", status: "Pending")

	# Associate pets with applications
	ApplicationPet.create!(application: @app1, pet: @pet1)
	ApplicationPet.create!(application: @app1, pet: @pet2)
	ApplicationPet.create!(application: @app2, pet: @pet2)
	end
  it "has a link to start an application when I click this link then I am taken to the new application where I see a form. Once I submit it I am taken to a completed page" do

    visit "/pets"

    expect(page).to have_link("Start an Application")
    click_link("Start an Application")

    expect(page).to have_current_path("/applications/new")

    fill_in 'Name', with: 'John Doe'
    fill_in 'Street Address', with: '123 Main St'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'CO'
    fill_in 'Zip Code', with: '80202'
    fill_in 'Description', with: 'I would make a great home because I love animals.'
    
    click_button("Submit")

    # Check that we are on the application's show page
    application = Application.last
    expect(page).to have_current_path("applications/#{application.id}")

    expect(page).to have_content(application.applicant_name)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip_code)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)

    expect(page).to have_content("In Progress")

  end

  it "lists all the pets with their attributes" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)

    visit "/pets"

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.breed)
    expect(page).to have_content(pet_1.age)
    expect(page).to have_content(shelter.name)

    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(pet_2.breed)
    expect(page).to have_content(pet_2.age)
    expect(page).to have_content(shelter.name)
  end

  it "only lists adoptable pets" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: false, age: 2, breed: "saint bernard", name: "Beethoven", shelter_id: shelter.id)

    visit "/pets"

    expect(page).to_not have_content(pet_3.name)
  end

  it "displays a link to edit each pet" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)

    visit "/pets"

    expect(page).to have_content("Edit #{pet_1.name}")
    expect(page).to have_content("Edit #{pet_2.name}")

    click_link("Edit #{pet_1.name}")

    expect(page).to have_current_path("/pets/#{pet_1.id}/edit")
  end

  it "displays a link to delete each pet" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)

    visit "/pets"

    expect(page).to have_content("Delete #{pet_1.name}")
    expect(page).to have_content("Delete #{pet_2.name}")

    click_link("Delete #{pet_1.name}")

    expect(page).to have_current_path("/pets")
    expect(page).to_not have_content(pet_1.name)
  end

  it "has a text box to filter results by keyword" do
    visit "/pets"
    expect(page).to have_button("Search")
  end

  it "lists partial matches as search results" do
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: "sphynx", name: "Bare-y Manilow", shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe", shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: shelter.id)

    visit "/pets"

    fill_in "Search", with: "Ba"
    click_on("Search")

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
    expect(page).to_not have_content(pet_3.name)
  end
end
