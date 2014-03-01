class Cheer < ActiveRecord::Base
  validates :goal, :user, :presence => true

  belongs_to :goal, :inverse_of => :cheers
  belongs_to :user, :inverse_of => :cheers
end
