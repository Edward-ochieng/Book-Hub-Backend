class DiscussionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "discussion_channel_#{params[:book_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    discussion = Discussion.create!(
      content: data['content'],
      book_id: data['book_id'],
      user_id: data['user_id']
    )
    
    ActionCable.server.broadcast(
      "discussion_channel_#{data['book_id']}", 
      {
        id: discussion.id,
        content: discussion.content,
        username: discussion.username,
        created_at: discussion.created_at
      }
    )
  end
end 