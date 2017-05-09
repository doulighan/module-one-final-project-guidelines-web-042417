class AddColumnToComments < ActiveRecord::Migration

  def change
    add_column :comments, :post_key, :string
  end
end
