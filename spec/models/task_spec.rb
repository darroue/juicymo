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
require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    @user = create(:user)
    @project = create(:project, user: @user)
  end

  describe '#create' do
    describe 'with valid attributes' do
      it 'creates task' do
        subject = Task.new(attributes_for(:task).merge(project: @project))

        expect(subject.save!).to be(true)
      end

      it 'raises Task count' do
        subject = Task.new(attributes_for(:task).merge(project: @project))

        expect { subject.save! }.to change(Task, :count).by(1)
      end
    end

    describe 'with invalid attributes' do
      it 'raises validation error' do
        subject = Task.new(attributes_for(:invalid_task).merge(project: @project))
        expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it "doesn't raise Task count" do
        subject = Task.new(attributes_for(:invalid_task).merge(project: @project))

        expect { subject.save }.to change(Task, :count).by(0)
      end
    end
  end

  describe '#destroy' do
    it 'destroys task' do
      subject = Task.new(attributes_for(:task).merge(project: @project))

      expect(subject.save!).to be(true)
    end
  end
end