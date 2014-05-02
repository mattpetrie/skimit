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

class Link < ActiveRecord::Base
  validates :title, :url, :submitter, presence: true

  belongs_to :submitter, class_name: 'User'

  has_many :link_shares

  has_many :subs, through: :link_shares
end
