class Favorites
  attr_reader :pets

  def initialize(pets = [])
    @pets = pets
  end

  def is_included?(id)
    pets.include? id
  end

  def add_pet(id)
    pets << id
  end

  def total_count
    pets.length
  end

  def delete_pets(ids)
    ids.each { |id| pets.delete(id.to_i) }
  end

  def empty?
    pets == []
  end
end
