class ReviewsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

     def index
      reviews = Review.all
      render json: reviews
     end


    def show
        book = review_finder
        render json: book
    end



    def create
        review = Review.create!(review_params)

        if review
            render json: review
        else
            render json: { errors: "validation errors"}, status: :unprocessable_entity
        
        end
      end

    
    def update
       review = review_finder
       puts review.book_id
       review.update!(review_params)
       render json: review
    rescue ActiveRecord::InvalidRecord => e
        render json: {error: e.record.errors.full_messages }, status: :unprocessable_entity
    
    end


    def destroy
     review = review_finder
     review.destroy
     head :no_content
    rescue ActiveRecord::InvalidRecord => e
        render json: {error: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    private

        def review_finder
            review = Review.find(params[:id]) 
        end

        def review_params
            params.permit(:user_id, :book_id, :comment)
          end

        def render_not_found_response
            render json: { error: "Review not found" }, status: :not_found
        end

       



end
