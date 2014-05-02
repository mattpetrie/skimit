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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    body Faker::Lorem.sentences(2).join("\n")
    link
    association :author, factory: :user
    parent_comment_id nil
  end
end
