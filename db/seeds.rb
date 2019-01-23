# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#20.times do |n|
#  name  = Faker::Name.name
#  email = "test-#{n+1}@ucas.ac.cn"
#  password = "123456"

    
    User.create!(name:  'admin',
               email: 'admin@mails.ucas.ac.cn',
               password:              '123456',
               password_confirmation:  '123456',
               admin: true)

#while Course.first
#    Course.last.destroy
#end

#while Teacher.first
#    Teacher.last.destroy
#end

#while Instruction.first
#    Instruction.last.destroy
#end
