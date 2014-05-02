# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  name         :string(255)      not null
#  moderator_id :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe Sub do
  subject(:sub) { build(:sub) }

  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:moderator) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "Associations" do
    it { should belong_to(:moderator) }
    it { should have_many(:links).through(:link_shares) }
  end
end
