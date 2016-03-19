class TeamAnnotation < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :user
  belongs_to :group
end
