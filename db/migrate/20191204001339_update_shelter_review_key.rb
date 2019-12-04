class UpdateShelterReviewKey < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :shelter_reviews, :shelters

    add_foreign_key :shelter_reviews, :shelters, on_delete: :cascade
  end
end
