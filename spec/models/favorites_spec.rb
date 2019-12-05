require 'rails_helper'

RSpec.describe Favorites do

  describe "#total_count" do
    it "can calculate total number of pets in favorites" do
      list = Favorites.new({
        1 => 1,
        2 => 1,
        3 => 1,
        4 => 1,
        5 => 1,
        })

      expect(list.total_count).to eq(5)
    end
  end
end
