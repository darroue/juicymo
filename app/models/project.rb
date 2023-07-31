# frozen_string_literal: true

# == Schema Information
#
# Table name: projects
#
#  id         :bigint           not null, primary key
#  position   :integer
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_projects_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Project < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tasks, dependent: :nulify

  validates :title, presence: true
  validates :position, uniqueness: { scope: :user_id }

  scope :for_user, lambda { |user|
    where(user:).order(:position, :updated_at)
  }

  def self.next_position_for_user(current_user)
    (for_user(current_user).order(:position).last&.position || 0).next
  end
end
