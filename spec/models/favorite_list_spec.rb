require "rails_helper"

describe FavoriteList do
  before :each do
    @list = FavoriteList.new({
      1 => 2,
      2 => 3
    })
  end

  describe "#total_count" do
    it "calculates total number of favorites" do
      expect(@list.total_count).to eq 5
    end
  end

  describe "#count_of" do
    it "returns the count of pets in favorites" do
      list = FavoriteList.new({})

      expect(list.count_of(5)).to eq 0
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