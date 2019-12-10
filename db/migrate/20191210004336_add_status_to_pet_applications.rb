class AddStatusToPetApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :pet_applications, :pending, :boolean, default: false
  end
end
