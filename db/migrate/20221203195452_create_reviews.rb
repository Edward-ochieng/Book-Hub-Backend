class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.integer :book_id
      t.integer :user_id
      t.string :comment

      t.timestamps
    end
  end
end
