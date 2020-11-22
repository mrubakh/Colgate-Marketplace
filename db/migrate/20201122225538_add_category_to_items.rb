class AddCategoryToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :category, :integer
  end
end
