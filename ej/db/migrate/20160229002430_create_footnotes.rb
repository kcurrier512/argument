class CreateFootnotes < ActiveRecord::Migration
  def change
    create_table :footnotes do |t|
    	t.text :content
    	t.integer :location
    	t.integer :draft_id
    	t.integer :user_id
      t.timestamps null: false
    end
  end
end
