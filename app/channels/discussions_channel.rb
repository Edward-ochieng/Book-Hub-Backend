class DiscussionsChannel < ApplicationCable::Channel
  def subscribed
    if params[:book_id].present?
      stream_from "book_#{params[:book_id]}"
    else
      reject
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end
end 