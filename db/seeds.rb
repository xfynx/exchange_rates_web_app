# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ExchangeRate.set_rate('EUR', 70, 'R01239')
ExchangeRate.set_rate('USD', 60, 'R01235')

User.create(email: 'admin@example.com', password: 'some-pass-word')