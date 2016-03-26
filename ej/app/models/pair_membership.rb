class PairMembership < ActiveRecord::Base
  belongs_to :pair
  belongs_to :user
end
