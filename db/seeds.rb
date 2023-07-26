# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'factory_bot_rails'
require 'faker'

include FactoryBot::Syntax::Methods

user_emails = []

3.times do
  user = create(:user, password: "123456")
  user_emails << user.email

  30.times do
    create(:project, user: user)
  end

  30.times do
    create(:tag, user: user)
  end

  Project.for_user(user).each do |project|
    rand(30).times do
      create(:task, project: project)
    end
  end
end

puts user_emails.inspect