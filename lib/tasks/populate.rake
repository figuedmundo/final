namespace :db do
  desc "Fill the database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Usuario",
                         last_name: "Ejemplo",
                         email: "admin@ejemplo.com",
                         password: "foobar",
                         password_confirmation: "foobar")
    admin.toggle!(:admin)
    10.times do |n|
      name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      email = "user#{n}@ejemplo.com"
      password = "foobar"
      user =  User.create!(name: name,
                           last_name: last_name,
                           email: email,
                           password: password,
                           password_confirmation: password)
      10.times do 
        content = Faker::Lorem.sentence(20)
        user.comments.create!(content: content)
      end
    end
  end
end