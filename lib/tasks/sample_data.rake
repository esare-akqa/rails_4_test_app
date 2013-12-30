namespace :db do
  desc 'Fill database will sample data' 
  task populate: :environment do
    puts 'Begin populating with sample users!'

    User.create!(name: 'Example User',
                 email: 'example@railstutorial.org',
                 password: 'foobar',
                 password_confirmation: 'foobar',
                 admin: true) 
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = 'password'
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    puts 'Finished populating with sample users!'
  end
end
