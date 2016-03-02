class Draft < ActiveRecord::Base
	belongs_to :post
	belongs_to :user
	has_many :tags
	has_many :footnotes
	acts_as_taggable
	
end
