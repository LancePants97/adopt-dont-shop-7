class CreateApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :applications do |t|
      t.string :applicatant_name
      t.string :street_address
      t.string :city
      t.string :state
      t.integer :zip_code

      t.timestamps
    end
  end
end
