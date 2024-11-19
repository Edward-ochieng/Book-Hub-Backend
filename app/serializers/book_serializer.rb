class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, :genre, :description, :price, :image

  has_many :reviews
end
