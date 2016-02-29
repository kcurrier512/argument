class Tag < ActiveRecord::Base
	belongs_to :drafts
	belongs_to :comments
	belongs_to :users
end
