class CreateDrafts < ActiveRecord::Migration
  def change
    create_table :drafts do |t|
    	t.text :content
    	t.string :title
    	t.integer :post_id
    	t.integer :user_id
      t.timestamps null: false
    end
  end
end
