require 'rails_helper'

RSpec.describe 'admin shelter index page', type: :feature do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    @app_1 = Application.create!(applicant_name: 'John Doe', street_address: '123 Main St', city: 'Denver', state: 'CO', zip_code: '80202', description: "I have a big yard", status: "In Progress")
    @app_2 = Application.create!(applicant_name: 'Jane Smith', street_address: '456 Elm St', city: 'Boulder', state: 'CO', zip_code: '80301', description: "I love animals", status: "Pending")
    @pet_app_1 = ApplicationPet.create!(application: @app_1, pet: @pet_1)
    @pet_app_2 = ApplicationPet.create!(application: @app_1, pet: @pet_2)
    @pet_app_3 = ApplicationPet.create!(application: @app_2, pet: @pet_2)    

  end

  it "shows the list of shelters in reverse alphabetical order by name" do
    visit "/admin/shelters"

    
    expect(page.body.index(@shelter_2.name)).to be < page.body.index(@shelter_3.name)
    expect(page.body.index(@shelter_3.name)).to be < page.body.index(@shelter_1.name)
  end

# User Story 11 - Shelters With Pending Applications
# As a visitor
# When I visit the admin shelter index ('/admin/shelters')
# Then I see a section for "Shelters with Pending Applications"
# And in this section I see the name of every shelter that has a pending application
    
  it 'has a list of shelters with pending applications' do
		visit "/admin/shelters"

		expect(page).to have_content("Shelters With Pending Applications")
    expect(Shelter.pending_apps).to eq([@shelter_1])
    # We know in this case that shelter_1 will be displayed on the page because pet_2 
    # belongs to shelter_1, and app_2 is the only app that is pending. Therefore pet_2 and
    # app_2 are both connected via pet_app_3 and shelter_1 will be the only shelter with
    # a pending application
	end

end