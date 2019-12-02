shelter_1 = Shelter.create(
  name:     "Winterfell",
  address:  "6303 W Exposition Ave",
  city:     "Lakewood",
  state:    "CO",
  zip:      "80226"
)
shelter_2 = Shelter.create(
  name:     "Sunspear",
  address:  "12322 Bohannon Blvd",
  city:     "Orlando",
  state:    "FL",
  zip:      "32824"
)
shelter_3 = Shelter.create(
  name:     "The Eyrie",
  address:  "257 Pearl St",
  city:     "Denver",
  state:    "CO",
  zip:      "80203"
)

shelter_1.pets.create(
  image:            "https://www.allthingsdogs.com/wp-content/uploads/2018/12/Husky-Names-Feature.jpg",
  name:             "Seamus",
  approximate_age:  8,
  sex:              "male",
  description:      "Winter is Coming; dog"
)
shelter_1.pets.create(
  image:            "https://www.catster.com/wp-content/uploads/2018/03/Calico-cat.jpg",
  name:             "Miso",
  approximate_age:  2,
  sex:              "female",
  description:      "Winter is Coming; cat"
)
shelter_1.pets.create(
  image:            "https://elknetwork.com/wp-content/uploads/2016/09/bull_elk.jpg",
  name:             "Coldhooves",
  approximate_age:  13,
  sex:              "male",
  description:      "Winter is Coming; elk"
)

shelter_2.pets.create(
  image:            "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234710/Chihuahua-On-White-03.jpg",
  name:             "Pepper",
  approximate_age:  4,
  sex:              "female",
  description:      "Unbowed, Unbent, Unbroken; dog"
)
shelter_2.pets.create(
  image:            "https://www.catster.com/wp-content/uploads/2018/01/Orange-tabby-cat-sleeping-with-eyes-closed.jpg",
  name:             "King",
  approximate_age:  3,
  sex:              "male",
  description:      "Unbowed, Unbent, Unbroken; cat"
)
shelter_2.pets.create(
  image:            "https://calphotos.berkeley.edu/imgs/512x768/0000_0000/1015/1960.jpeg",
  name:             "Tyene",
  approximate_age:  8,
  sex:              "female",
  description:      "Unbowed, Unbent, Unbroken; snake"
)

shelter_3.pets.create(
  image:            "https://66.media.tumblr.com/c5bf6cdcaee47951b8de1cce0b8bf38c/tumblr_pefavaiomz1wd2e41o1_500.png",
  name:             "Viserion",
  approximate_age:  14,
  sex:              "male",
  description:      "As High as Honor; dragon"
)
shelter_3.pets.create(
  image:            "https://allthatsinteresting.com/wordpress/wp-content/uploads/2019/01/megalodon-eats-man.jpg",
  name:             "Megalodon",
  approximate_age:  9,
  sex:              "female",
  description:      "As High As Honor; fish"
)
shelter_3.pets.create(
  image:            "https://www.eagles.org/wp-content/uploads/2015/01/post21.jpg",
  name:             "Colbert",
  approximate_age:  1,
  sex:              "male",
  description:      "As High As Honor; bird"
)
