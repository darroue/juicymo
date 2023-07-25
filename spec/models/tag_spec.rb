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
require 'rails_helper'

RSpec.describe Tag, type: :model do
  before do
    @user = create(:user)
  end

  describe '#create' do
    describe 'with valid attributes' do
      it 'creates tag' do
        subject = Tag.new(attributes_for(:tag).merge(user: @user))

        expect(subject.save!).to be(true)
      end

      it 'raises Tag count' do
        subject = Tag.new(attributes_for(:tag).merge(user: @user))

        expect { subject.save! }.to change(Tag, :count).by(1)
      end
    end

    describe 'with invalid attributes' do
      it 'raises validation error' do
        subject = Tag.new(attributes_for(:invalid_tag).merge(user: @user))
        expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it "doesn't raise Tag count" do
        subject = Tag.new(attributes_for(:invalid_tag).merge(user: @user))

        expect { subject.save }.to change(Tag, :count).by(0)
      end
    end
  end

  describe '#destroy' do
    it 'destroys tag' do
      subject = Tag.create(attributes_for(:tag).merge(user: @user))

      expect {subject.destroy}.to change {Tag.count}.by(-1)
    end
  end

  describe '.for_user(user)' do
    it 'should return only user projects' do
      Tag.create(attributes_for(:tag).merge(user: @user))
      3.times { Tag.create(attributes_for(:tag).merge(user: create(:user))) }

      expect(Tag.for_user(@user).pluck(:user_id).uniq).to eq([@user.id])
    end
  end
end