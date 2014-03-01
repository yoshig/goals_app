# == Schema Information
#
# Table name: goals
#
#  id          :integer          not null, primary key
#  title       :string(255)      not null
#  description :text
#  user_id     :integer          not null
#  completed   :boolean          default(FALSE)
#  public      :boolean          default(FALSE)
#  created_at  :datetime
#  updated_at  :datetime
#

class Goal < ActiveRecord::Base
  include Commentable
  validates :title, :user, :presence => true
  before_validation :ensure_booleans_set

  belongs_to :user, :inverse_of => :goals
  has_many :cheers, :inverse_of => :goal

  def karma
    self.cheers.count
  end

  def ensure_booleans_set
    self.completed ||= false
    if self.privacy.nil?
      self.privacy = true
    end
  end

  def toggle_completion!
    self.completed = !self.completed
    self.save!
  end

  def toggle_privacy!
    self.privacy = !self.privacy
    self.save!
  end
end
