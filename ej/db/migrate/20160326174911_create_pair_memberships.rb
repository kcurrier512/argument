class CreatePairMemberships < ActiveRecord::Migration
  def change
    create_table :pair_memberships do |t|
      t.integer :user_id
      t.integer :pair_id
      t.timestamps null: false
    end
  end
end
