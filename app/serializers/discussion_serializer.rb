class DiscussionSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :user_id, :username

  def initialize(*args)
    Rails.logger.debug "SERIALIZER DEBUG: Initializing with args #{args.inspect}"
    super
    Rails.logger.debug "SERIALIZER DEBUG: After initialization, object is #{@object.inspect}"
    Rails.logger.debug "SERIALIZER DEBUG: After initialization, instance options are #{@instance_options.inspect}"
  end

  def username
    Rails.logger.debug "SERIALIZER DEBUG: In username method"
    Rails.logger.debug "SERIALIZER DEBUG: object is #{object.inspect}"
    Rails.logger.debug "SERIALIZER DEBUG: user is #{object.user.inspect}"
    Rails.logger.debug "SERIALIZER DEBUG: attempting to get username"
    object.user.username
  end
end 