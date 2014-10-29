# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.transaction do
  30.times do |i|
    User.create(user_name: Faker::Internet.user_name, password: "asdfasdf#{i}")
  end
end

Cat.transaction do
  user_ids = User.all.pluck(:id)
  300.times do 
    Cat.create(name: Faker::Name.name, color: "black", sex: "M",
    birth_date: Faker::Date.backward(10000), description: Faker::Hacker.say_something_smart,
    user_id: user_ids.sample )
  end
end
#
# CatRentalRequest.transaction do
#   requester_ids = User.all.pluck(:id)
#   cat_ids = Cat.all.pluck(:id)
#   250.times do
#     cat_id = cat_ids.sample
#     requester_id = requester_ids.sample until requester_id != Cat.find(cat_id).user_id
#     CatRentalRequest.create(user_id: requester_id, cat_id: cat_id, start_date: Faker::Date.between(Date.today, Date.new(2015,1,1)), end_date: Faker::Date.between(Date.new(2015,11,11), Date.new(2016,1,1)))
#   # end
# end