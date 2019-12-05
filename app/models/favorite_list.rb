class FavoriteList
  attr_reader :contents

  def initialize(initial_pets)
    @contents = initial_pets || Hash.new()
  end

  def total_count
    @contents.values.sum
  end
  
  def count_of(id)
    @contents[id.to_s].to_i
  end

  def add_pet(id)
    @contents[id.to_s] = count_of(id) + 1
  end
end