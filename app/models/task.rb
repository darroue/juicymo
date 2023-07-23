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
class Task < ApplicationRecord
  belongs_to :project

  validates :title, presence: true
  has_one_attached :attachment

  scope :for_user, -> (current_user) {
    joins(:project).where(
      projects: {
        user: current_user
      }
    )
  }
end
