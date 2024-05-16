require "rails_helper"

RSpec.describe Application do
	it "shows the application and all it's attributes" do
    application_1 = Application.create(
			id: 1, 
			applicant_name: "John Doe", 
			street_address: "1141 Hollywood blvd", 
			city: "Point Pleasant", 
			state: "New Jersey",
			zip_code: "08742"
		)

    visit "/applications/#{application_1.id}"
		save_and_open_page

    expect(page).to have_content(application_1.applicant_name)
    expect(page).to have_content(application_1.street_address)
    expect(page).to have_content(application_1.city)
    expect(page).to have_content(application_1.state)
    expect(page).to have_content(application_1.zip_code)
  end
end