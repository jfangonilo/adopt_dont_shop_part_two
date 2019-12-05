require "rails_helper"

describe FavoriteList do
  before :each do
    cats = create_list(:random_pet, 5)
    @list = FavoriteList.new(cats)
  end

  describe "#total_count" do
    it "calculates total number of favorites" do
      expect(@list.total_count).to eq 5
    end
  end

  describe "#add_pet" do
    it "adds a pet to the list" do
      new_cat = create(:random_pet)
      @list.add_pet(new_cat)

      expect(@list.total_count).to eq 6
    end
  end
end