class CreateComments < ActiveRecord::Migration

  def change
    create_table :comments do |t|
      t.integer :parent_id
      t.integer :post_id
      t.string  :body
      t.integer :user_id
      t.timestamps
    end
  end
end
