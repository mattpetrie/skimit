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

  has_many :comments

  has_many :user_votes

  def comments_by_parent_id
    comments = Comment.where(link: self)
    comment_family = Hash.new { |h,k| h[k] = [] }

    comments.each do |comment|
      comment_family[comment.parent_comment_id] << comment
    end
    comment_family
  end

  def votes
    self.user_votes.sum(:value)
  end
end
