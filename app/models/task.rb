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
  has_one_attached :attachment
  has_many :task_tags, dependent: :destroy
  has_many :tags, through: :task_tags

  validates :title, presence: true

  scope :for_user, lambda { |current_user|
    includes(:project).where(
      projects: {
        user: current_user
      }
    ).order(:created_at)
  }

  scope :for_params, lambda { |scope, params|
    if (project_ids = params[:project_ids].try(:reject, &:empty?)).present?
      scope = scope.where(project_id: project_ids)
    end

    if (tag_ids = params[:tag_ids].try(:reject, &:empty?)).present?
      scope = scope.joins(:tags).where(tags: { id: tag_ids })
    end

    scope
  }
end
