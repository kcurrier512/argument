class Pair < ActiveRecord::Base
  has_many :pair_memberships
  has_many :users, through: :pair_memberships
  has_many :footnotes
  accepts_nested_attributes_for :pair_memberships, allow_destroy: true
end
