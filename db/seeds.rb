# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Customer.destroy_all
Subscription.destroy_all
Tea.destroy_all
customer_1 = Customer.create(first_name: "Normand",last_name: "Rutherford",email: "jackson@mraz.info", address: "504 Sporer Loop, New Ines, KS 00636")
sub_1 = Subscription.create(title: "Diamond",price: 46.28,status: "active",frequency: "Biennal", customer_id: customer_1.id)
sub_2 = Subscription.create(title: "Free Trial",price: 41.28,status: "active",frequency: "Monthly", customer_id: customer_1.id)
sub_3 = Subscription.create(title: "Bronze",price: 410.28,status: "cancelled",frequency: "Monthly", customer_id: customer_1.id)
tea_1 = Tea.create(title: "Lu'an Melon Seed",temperature: 65.29,brew_time: 0)
tea_sub_1 = TeaSubscription.create(subscription_id: sub_1.id, tea_id: tea_1.id)
