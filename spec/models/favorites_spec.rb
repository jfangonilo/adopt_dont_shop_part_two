require 'rails_helper'

RSpec.describe Favorites do

  describe "#add_pet" do
    it "adds a pet to favorites" do
      list = Favorites.new
      list.add_pet(1)

      expect(list.contents).to eq({'1' => 1})
    end
  end

  describe "#total_count" do
    it "can calculate total number of pets in favorites" do
      list = Favorites.new({
        '1' => 1,
        '2' => 1,
        '3' => 1,
        '4' => 1,
        '5' => 1,
        })

      expect(list.total_count).to eq(5)
    end
  end

  describe "#delete_pets" do
    it "deletes pet(s) from favorites" do
      list = Favorites.new
      list.add_pet(1)
      list.delete_pets([1])

      expect(list.contents).to eq({})
      
      list.add_pet(1)
      list.add_pet(2)
      list.delete_pets([1,2])
      expect(list.contents).to eq({})
    end
  end

  describe "#empty?" do
    it "returns true if empty" do
      list = Favorites.new
      expect(list.empty?).to eq true
    end
  end

end
