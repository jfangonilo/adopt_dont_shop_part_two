class Favorites
  attr_reader :contents

  def initialize(initial_contents = [])
    @contents = initial_contents
  end

  def is_included?(id)
    contents.include? id
  end

  def add_pet(id)
    contents << id
  end

  def total_count
    contents.length
  end

  def delete_pets(ids)
    ids.each { |id| contents.delete(id.to_i) }
  end

  def empty?
    @contents == []
  end
end
