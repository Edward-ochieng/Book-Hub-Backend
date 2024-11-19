class BooksController < ApplicationController
     before_action :authorize

    def index
        books = Book.all
        render json: books
    end

    def show
        book = Book.find_by(id: params[:id])
        render json: book
    end

    


    private

        

         def authorize
             return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
           end

    
end
