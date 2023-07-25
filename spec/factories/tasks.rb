# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  description :text
#  is_done     :boolean          default(FALSE), not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  project_id  :bigint           not null
#
# Indexes
#
#  index_tasks_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
FactoryBot.define do
  factory :task do
    title { Faker::Commerce.product_name }
    description { Faker::Quote.famous_last_words }
    is_done { Faker::Boolean.boolean }
    association :project
  end

  factory :invalid_task, parent: :task do
    title { nil }
    project { nil }
  end
end
