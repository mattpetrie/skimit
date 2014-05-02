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

require 'spec_helper'

describe UserVote do
  pending "add some examples to (or delete) #{__FILE__}"
end
