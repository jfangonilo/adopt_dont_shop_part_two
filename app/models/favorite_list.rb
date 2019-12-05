class FavoriteList

  def initialize(initial_pets)
    @contents = initial_pets
  end

  def total_count
    @contents.length
  end

end