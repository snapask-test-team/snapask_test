# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "create user"
User.create(email: 'test@gmail.com', password: '123456')

puts "create category and course"
category = Category.create(name: "Calculas")
Category.create(name: "Physical")
Category.create(name: "English")
Category.create(name: "Chinese")
Category.create(name: "Others")

Course.create(subject: "Math", 
              price: 300.0,
              currency: "TWD",
              launch: true,
              url: "http://localhost:3000", 
              description: "This is Math course",
              expire_day: 30,
              category_id: category.id 
            )

puts "create manager"
Manager.create(email: "manager1@gmail.com", password: "123456")