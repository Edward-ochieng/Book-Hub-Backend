class Discussion < ApplicationRecord
  include PublicActivity::Model
  tracked
  
  belongs_to :book
  belongs_to :user
  
  validates :content, presence: true

  def username
    user.username
  end
end 