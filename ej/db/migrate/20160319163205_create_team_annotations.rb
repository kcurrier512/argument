class CreateTeamAnnotations < ActiveRecord::Migration
  def change
    create_table :team_annotations do |t|
      t.text :content
      t.integer :user_id
      t.integer :group_id
      t.integer :assignment_id
      t.timestamps null: false
    end
  end
end
