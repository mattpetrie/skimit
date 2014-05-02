# == Schema Information
#
# Table name: user_votes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  link_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  value      :integer
#

class UserVote < ActiveRecord::Base
  validates :user, :link, presence: true
  belongs_to :user
  belongs_to :link
end
