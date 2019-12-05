class Favorites

  def initialize(initial_contents)
    @contents = initial_contents
  end

  def total_count
    @contents.values.sum
  end

end
