require 'rails_helper'

RSpec.describe 'admin shelter index page', type: :feature do
    before(:each) do
        @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
        @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
        @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
        @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
        @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
        @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    end

    it "shows the list of shelters in reverse alphabetical order by name" do
        visit "/admin/shelters"
    
        expect(page.body.index(@shelter_2.name)).to be < page.body.index(@shelter_3.name)
        expect(page.body.index(@shelter_3.name)).to be < page.body.index(@shelter_1.name)
    end
end