# frozen_string_literal: true

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
#  user_id     :bigint           not null
#
# Indexes
#
#  index_tasks_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :task do
    title { Faker::Commerce.product_name }
    description { Faker::Quote.famous_last_words }
    is_done { Faker::Boolean.boolean }
  end

  factory :invalid_task, parent: :task do
    title { nil }
  end
end
