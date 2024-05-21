require 'rails_helper'

RSpec.describe 'admin shelter index page', type: :feature do
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

	# Application number 1
	@app1 = Application.create!(applicant_name: 'John Doe', street_address: '123 Main St', city: 'Denver', state: 'CO', zip_code: '80202', description: "I have a big yard", status: "In Progress")

	# Application number 2
	@app2 = Application.create!(applicant_name: 'Jane Smith', street_address: '456 Elm St', city: 'Boulder', state: 'CO', zip_code: '80301', description: "I love animals", status: "Pending")

	# Associate pets with applications
	ApplicationPet.create!(application: @app1, pet: @pet1)
	ApplicationPet.create!(application: @app1, pet: @pet2)
	ApplicationPet.create!(application: @app2, pet: @pet2)
	end

    # As a visitor
    # When I visit an admin application show page ('/admin/applications/:id')
    # For every pet that the application is for, I see a button to approve the application for that specific pet
    # When I click that button
    # Then I'm taken back to the admin application show page
    # And next to the pet that I approved, I do not see a button to approve this pet
    # And instead I see an indicator next to the pet that they have been approved
    it "allows me to approve the application for a specific pet" do
        visit "/admin/applications/#{@app2.id}"
        expect(page).to have_button("Approve")
        click_button("Approve")
        expect(page).to have_current_path("/admin/applications/#{@app2.id}")
        expect(page).to_not have_button("Approve")
        expect(page).to have_content("Approved")
    end

    it "allows me to reject the application for a specific pet" do
        visit "/admin/applications/#{@app2.id}"
        expect(page).to have_button("Reject")
        click_button("Reject")
        expect(page).to have_current_path("/admin/applications/#{@app2.id}")
        expect(page).to_not have_button("Reject")
        expect(page).to have_content("Rejected")
        save_and_open_page
    end

        # As a visitor
    # When there are two applications in the system for the same pet
    # When I visit the admin application show page for one of the applications
    # And I approve or reject the pet for that application
    # When I visit the other application's admin show page
    # Then I do not see that the pet has been accepted or rejected for that application
    # And instead I see buttons to approve or reject the pet for this specific application
    it "only changes the status of one application if I approve or reject it" do
        visit "/admin/applications/#{@app3.id}"

        save_and_open_page
        click_button("Approve")
        visit "/admin/applications/#{@app4.id}" 
        save_and_open_page
        expect(page).to have_button("Approve")
        expect(page).to have_button("Reject")
    end 

end