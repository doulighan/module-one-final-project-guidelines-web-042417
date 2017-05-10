class AddIndicesToPosts < ActiveRecord::Migration[5.1]
  def change
    add_index :posts, :post_id
    add_index :posts, :author
    add_index :posts, :score 
  end
end
