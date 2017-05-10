class AddIndicesToComments < ActiveRecord::Migration[5.1]
  def change
    add_index :comments, :comment_id
    add_index :comments, :parent_id
    add_index :comments, :post_id
    add_index :comments, :author
    add_index :comments, :score
  end
end
