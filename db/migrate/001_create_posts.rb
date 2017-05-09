class CreatePosts < ActiveRecord::Migration[5.1]

  def change
    create_table :posts, id: false do |t|
      t.text :post_id, primary_key: true
      t.string :title
      t.string :author
      t.integer :score
      t.string :subreddit
      t.timestamps

    end

  end
end
