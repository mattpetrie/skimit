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

class Sub < ActiveRecord::Base
  validates :name, :moderator, presence: true
  validates_uniqueness_of :name

  belongs_to :moderator, class_name: 'User'

  has_many :link_shares

  has_many :links, through: :link_shares
end
