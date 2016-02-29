class Footnote < ActiveRecord::Base
	belongs_to :draft
	belongs_to :user
end
