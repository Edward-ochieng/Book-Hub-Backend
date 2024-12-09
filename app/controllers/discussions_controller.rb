class DiscussionsController < ApplicationController
  before_action :authorize
  
  def index
    book = Book.find(params[:book_id])
    discussions = book.discussions.order(created_at: :desc)
    render json: discussions, methods: [:username]
  end

  def create
    Rails.logger.debug "CONTROLLER DEBUG: Starting create with params #{params.inspect}"
    discussion = Discussion.new(discussion_params)
    discussion.user_id = session[:user_id]
    
    if discussion.save
      Rails.logger.debug "CONTROLLER DEBUG: discussion is #{discussion.inspect}"
      Rails.logger.debug "CONTROLLER DEBUG: discussion.user is #{discussion.user.inspect}"
      
      # Create the response data
      response_data = {
        id: discussion.id,
        content: discussion.content,
        created_at: discussion.created_at,
        user_id: discussion.user_id,
        username: discussion.username
      }
      
      Rails.logger.debug "RENDER DEBUG: response_data is #{response_data.inspect}"
      
      # Render first
      render json: response_data, status: :created
      
      # Then broadcast
      ActionCable.server.broadcast "book_#{discussion.book_id}", response_data
    else
      render json: { errors: discussion.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    discussion = Discussion.find(params[:id])
    if discussion.user_id == session[:user_id]
      discussion.destroy
      # Broadcast the deletion
      ActionCable.server.broadcast "book_#{discussion.book_id}", {
        action: "delete",
        id: discussion.id
      }
      head :no_content
    else
      render json: { error: "Not authorized" }, status: :unauthorized
    end
  end

  private

  def discussion_params
    # Only permit content and book_id from the root level params
    params.permit(:content, :book_id)
  end

  def authorize
    return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
  end
end 