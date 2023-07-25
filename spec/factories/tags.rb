# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_tags_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :tag do
    title { Faker::Commerce.product_name }
    association :user
  end

  factory :invalid_tag, parent: :tag do
    title { nil }
  end
end
