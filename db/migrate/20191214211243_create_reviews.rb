class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.integer :rating
      t.string :content
      t.string :picture, default: "https://s3.amazonaws.com/petfinder-us-east-1-petimages-prod/organization-photos/34184/34184-2.jpg?bust=2018-04-13+01%3A36%3A57"

      t.timestamps

      drop_table :shelter_reviews
    end
  end
end
