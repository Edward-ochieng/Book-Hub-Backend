class Book < ApplicationRecord
  include PublicActivity::Model
  tracked
    has_many :reviews
    has_many :users, through: :reviews
end
