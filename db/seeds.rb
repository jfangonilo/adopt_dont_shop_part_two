shelter_1 = FactoryBot.create(:random_shelter)
shelter_2 = FactoryBot.create(:random_shelter)
shelter_3 = FactoryBot.create(:random_shelter)

pets_1 = FactoryBot.create_list(:random_pet, 3, shelter: shelter_1)
pets_2 = FactoryBot.create_list(:random_pet, 3, shelter: shelter_2)
pets_3 = FactoryBot.create_list(:random_pet, 3, shelter: shelter_3)

reviews_3 = FactoryBot.create_list(:random_review, 3, shelter: shelter_1)
reviews_3 = FactoryBot.create_list(:random_review, 3, shelter: shelter_2)
reviews_3 = FactoryBot.create_list(:random_review, 3, shelter: shelter_3)

# seed 3 applications, each applying for a pet at a different shelter
# application_0 = FactoryBot.create(:application)
# application_0.pets << pets_1[0]
# application_0.pets << pets_2[0]
# application_0.pets << pets_3[0]
# application_1 = FactoryBot.create(:application)
# application_1.pets << pets_1[1]
# application_1.pets << pets_2[1]
# application_1.pets << pets_3[1]
# application_2 = FactoryBot.create(:application)
# application_2.pets << pets_1[2]
# application_2.pets << pets_2[2]
# application_2.pets << pets_3[2]
# single sad pet w/ no application
FactoryBot.create(:random_pet)
