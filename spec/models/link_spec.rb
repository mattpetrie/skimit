# == Schema Information
#
# Table name: links
#
#  id           :integer          not null, primary key
#  title        :string(255)      not null
#  text         :text
#  url          :string(255)      not null
#  submitter_id :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe Link do
  subject(:link) { create(:link) }

  describe "Validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:submitter) }
  end

  describe "Associations" do
    it { should belong_to(:submitter) }
    it { should have_many(:link_shares) }
    it { should have_many(:subs).through(:link_shares) }
  end

  describe "#comments_by_parent_id" do
    let!(:top_level_comment) { create(:comment, link_id: link.id) }
    let!(:child_comment) { create(:comment,
                            parent_comment: top_level_comment,
                            link: link) }

    it "returns a hash with comment_id => [child comments]" do
      expect(link.comments_by_parent_id).to eq({
        nil => [top_level_comment],
        top_level_comment.id => [child_comment]
        })
    end
  end

end
