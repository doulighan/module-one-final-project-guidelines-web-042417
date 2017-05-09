class AddColumnToPosts < ActiveRecord::Migration

  def change
    add_column :posts, :post_key, :string
  end

end
