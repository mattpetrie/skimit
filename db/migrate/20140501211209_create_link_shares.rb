class CreateLinkShares < ActiveRecord::Migration
  def change
    create_table :link_shares do |t|
      t.integer :link_id, null: false
      t.integer :sub_id, null: false

      t.timestamps
    end

    add_index :link_shares, :link_id
    add_index :link_shares, :sub_id
  end
end
