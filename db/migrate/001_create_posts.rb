class CreatePosts < ActiveRecord::Migration[5.1]
  
  def change
    create_table :posts, id: false do |t|
      t.text :post_id, primary_key: true
      t.string :title
      t.string :body
      t.string :author
      t.timestamps

    end

  end
end
