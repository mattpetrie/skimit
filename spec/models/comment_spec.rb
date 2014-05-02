# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  body              :text             not null
#  link_id           :integer          not null
#  author_id         :integer          not null
#  parent_comment_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

require 'spec_helper'

describe Comment do
  subject(:comment) { build(:comment) }

  describe 'Validations' do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:link) }
    it { should validate_presence_of(:author) }
  end

  describe 'Associations' do
    it { should belong_to(:link) }
    it { should belong_to(:author) }
    it { should have_many(:child_comments) }
    it { should belong_to(:parent_comment) }
  end
end
