class Comment < ActiveRecord::Base
  validates :body, :user, :commentable, :presence => true

  belongs_to :user
  belongs_to :commentable, polymorphic: true
end
