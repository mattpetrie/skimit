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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_vote do
    user nil
    link nil
  end
end
