class CreateComments < ActiveRecord::Migration[5.1]

  def change
    create_table :comments, id: false do |t|
      t.text :comment_id, primary_key: true
      t.string :parent_id
      t.string :post_id
      t.string :body
      t.string :author
      t.integer :score
      
    end
  end
end
