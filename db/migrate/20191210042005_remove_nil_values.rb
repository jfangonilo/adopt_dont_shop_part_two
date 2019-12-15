class RemoveNilValues < ActiveRecord::Migration[5.1]
  def change
    remove_column :pet_applications, :pending
    add_column :pet_applications, :pending, :boolean, null: false, default: false

    remove_column :pets, :adoptable
    add_column :pets, :adoptable, :boolean, null: false, default: true
  end
end
