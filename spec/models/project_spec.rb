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
require 'rails_helper'

RSpec.describe Project, type: :model do
  before do
    @user = create(:user)
  end

  describe '#create' do
    describe 'with valid attributes' do
      it 'creates project' do
        subject = Project.new(attributes_for(:project).merge(user: @user))

        expect(subject.save!).to be(true)
      end

      it 'raises Project count' do
        subject = Project.new(attributes_for(:project).merge(user: @user))

        expect { subject.save! }.to change(Project, :count).by(1)
      end
    end

    describe 'with invalid attributes' do
      it 'raises validation error' do
        subject = Project.new(attributes_for(:invalid_project).merge(user: @user))
        expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it "doesn't raise Project count" do
        subject = Project.new(attributes_for(:invalid_project).merge(user: @user))

        expect { subject.save }.to change(Project, :count).by(0)
      end
    end
  end

  describe '#destroy' do
    it 'destroys project' do
      subject = Project.create(attributes_for(:project).merge(user: @user))

      expect {subject.destroy}.to change {Project.count}.by(-1)
    end
  end

  describe '.for_user(user)' do
    it 'should return only user projects' do
      Project.create(attributes_for(:project).merge(user: @user))
      3.times { Project.create(attributes_for(:project).merge(user: create(:user))) }

      expect(Project.for_user(@user).pluck(:user_id).uniq).to eq([@user.id])
    end
  end
end