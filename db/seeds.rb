require 'factory_bot'
FactoryBot.find_definitions

shelters = FactoryBot.create_list(:random_shelter, 3)
shelters.each { |shelter| FactoryBot.create_list(:random_pet, 3, shelter: shelter) }
shelters.each { |shelter| FactoryBot.create_list(:random_shelter_review, 3, shelter: shelter) }
