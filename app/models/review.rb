class Review < ApplicationRecord
  include PublicActivity::Model
  tracked
    belongs_to :book
    belongs_to :user
end
