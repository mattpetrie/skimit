class LinkShare < ActiveRecord::Base
  validates :link, :sub, presence: true

  belongs_to :link
  belongs_to :sub
end