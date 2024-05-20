require "rails_helper"

RSpec.describe Application do
	before(:each) do
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
	
		# Application number 2
		@app3 = Application.create!(applicant_name: 'Harry Potter', street_address: '789 Hogwarts Ave', city: 'Portland', state: 'OR', zip_code: '45301', description: "I can do magic", status: "In Progress")

	# Associate pets with applications
		ApplicationPet.create!(application: @app1, pet: @pet1)
		ApplicationPet.create!(application: @app1, pet: @pet2)
		ApplicationPet.create!(application: @app2, pet: @pet2)
	end

	it "shows the application and all it's attributes" do
    visit "/applications/#{@app1.id}"

    expect(page).to have_content(@app1.applicant_name)
    expect(page).to have_content(@app1.street_address)
    expect(page).to have_content(@app1.city)
    expect(page).to have_content(@app1.state)
    expect(page).to have_content(@app1.zip_code)
    expect(page).to have_content(@app1.description)
    expect(page).to have_content(@app1.status)

		expect(page).to have_content(@pet1.name)
		expect(page).to have_content(@pet1.name)
	end

# 	[ ] done

# 4. Searching for Pets for an Application

# As a visitor
# When I visit an application's show page
# And that application has not been submitted,
# Then I see a section on the page to "Add a Pet to this Application"
# In that section I see an input where I can search for Pets by name
# When I fill in this field with a Pet's name
# And I click submit,
# Then I am taken back to the application show page
# And under the search bar I see any Pet whose name matches my search

	it 'shows an option to search and add a pet to the application' do
		visit "/applications/#{@app1.id}"
	
		expect(page).to have_content("Add a Pet to this Application")
		expect(page).to have_button("Submit")

		fill_in :search, with: "Rex"
		
		# save_and_open_page
		click_on("Submit")
		# expect(page).to have_current_path("/applications/#{@app2.id}")
		expect(page).to have_current_path("/applications/#{@app1.id}?search=Rex")

		expect(page).to have_content(@pet3.name)
	end

# 	As a visitor
# When I visit an application's show page
# And I search for a Pet by name
# And I see the names Pets that match my search
# Then next to each Pet's name I see a button to "Adopt this Pet"
# When I click one of these buttons
# Then I am taken back to the application show page
# And I see the Pet I want to adopt listed on this application

	it ' lets you add a pet to the application' do
		visit "/applications/#{@app1.id}"

		fill_in :search, with: "Rex"
		click_on("Submit")
		expect(page).to have_content("Rex")
		expect(page).to have_button("Adopt this Pet")
		click_on("Adopt this Pet")
		expect(page).to have_current_path("/applications/#{@app1.id}")
		expect(page).to have_content("Rex")
	end
		
	# As a visitor
# When I visit an application's show page
# And I have added one or more pets to the application
# Then I see a section to submit my application
# And in that section I see an input to enter why I would make a good owner for these pet(s)
# When I fill in that input
# And I click a button to submit this application
# Then I am taken back to the application's show page
# And I see an indicator that the application is "Pending"
# And I see all the pets that I want to adopt
# And I do not see a section to add more pets to this application

	it 'lets you submit the application' do
		visit "/applications/#{@app1.id}"

		expect(page).to have_button("Submit Application")
		expect(page).to have_content("Why I would make a good owner for these pet(s)")
		# note that good owner and good home are two separate fields
		fill_in :why_good_owner, with: "I had a dog growing up"
		click_on("Submit Application")
		expect(page).to have_current_path "/applications/#{@app1.id}"
		
		expect(page).to have_content("Pending")
		expect(page).to have_content("Mittens")
		expect(page).to have_content("Buddy")
		expect(page).to_not have_content("Adopt this Pet")
	end

	it "won't save if no pets are on an Applications page" do
		visit "/applications/#{@app3.id}"

		expect(page).to_not have_button("Submit Application")
	end

	it "Lets you find pets with only partial names" do
		visit "/applications/#{@app1.id}"

		fill_in :search, with: "Re"
		click_on("Submit")
		expect(page).to have_content("Rex")
	end

	it "Lets you find pets with names regardless of case sensitivity" do
		visit "/applications/#{@app1.id}"

		fill_in :search, with: "simb"
		click_on("Submit")
		expect(page).to have_content("Simba")
	end
end