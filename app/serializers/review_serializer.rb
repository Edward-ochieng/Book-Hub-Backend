class ReviewSerializer < ActiveModel::Serializer 
  attributes   :id, :comment, :user_id, :username

  def username
    object.user.username
  end
  
end
