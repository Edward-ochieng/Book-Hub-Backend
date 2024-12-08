module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      # For API mode, we'll accept any user for now
      # In production, you'd want to implement proper authentication
      User.find_by(id: request.params[:user_id]) || reject_unauthorized_connection
    end
  end
end 