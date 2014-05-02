class CreateUserVotes < ActiveRecord::Migration
  def change
    create_table :user_votes do |t|
      t.references :user, index: true
      t.references :link, index: true

      t.timestamps
    end
  end
end
