class CreateSubreddit < ActiveRecord::Migration[5.1]

  def change
    create_table :subreddit, id: false do |t|
      t.text :subreddit_id
      t.text :title
    end
  end
end
