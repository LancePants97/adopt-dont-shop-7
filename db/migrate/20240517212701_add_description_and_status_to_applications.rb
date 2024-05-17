class AddDescriptionAndStatusToApplications < ActiveRecord::Migration[7.1]
  def change
    add_column :applications, :description, :string
    add_column :applications, :status, :string
  end
end
