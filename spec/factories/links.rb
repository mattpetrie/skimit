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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    title Faker::Commerce.product_name
    text Faker::Lorem.sentence
    url Faker::Internet.url
    association :submitter, factory: :user
  end
end
