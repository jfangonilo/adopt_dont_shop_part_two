require "rails_helper"

describe PetApplication do
  it {should belong_to :pet}
  it {should belong_to :application}
end