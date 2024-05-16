class FixTypoInSchema < ActiveRecord::Migration[7.1]
  def change
    rename_column :applications, :applicatant_name, :applicant_name
    change_column :applications, :zip_code, :string
  end
end
