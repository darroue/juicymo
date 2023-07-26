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
  user = begin
    create(:user, password: '123456')
  rescue StandardError
    next
  end
  user_emails << user.email

  project_attrs = []
  30.times do
    project_attrs << attributes_for(:project, user_id: user.id)
  rescue StandardError
    next
  end
  projects = Project.create(project_attrs)


  tag_attrs = []
  30.times do
    tag_attrs << attributes_for(:tag, user_id: user.id)
  rescue StandardError
    next
  end
  tags = Tag.create(tag_attrs)

  tasks = []
  30.times do
    tasks << attributes_for(:task, user_id: user.id, project_ids: projects.sample(rand(10)).map(&:id),
                                   tag_ids: tags.sample(rand(10)).map(&:id))
  rescue StandardError
    next
  end

  Task.create(tasks)
end

puts user_emails.inspect
