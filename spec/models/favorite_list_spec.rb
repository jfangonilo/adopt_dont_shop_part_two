require "rails_helper"

describe FavoriteList do
  before :each do
    @cats = create_list(:random_pet, 5)
  end

  describe "#total_count" do
    it "calculates total number of favorites" do
      list = FavoriteList.new(@cats)

      expect(list.total_count).to eq 5
    end
  end
end