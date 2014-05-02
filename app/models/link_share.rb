# == Schema Information
#
# Table name: link_shares
#
#  id         :integer          not null, primary key
#  link_id    :integer          not null
#  sub_id     :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class LinkShare < ActiveRecord::Base
  validates :link, :sub, presence: true

  belongs_to :link
  belongs_to :sub
end
