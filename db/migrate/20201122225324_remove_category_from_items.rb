class RemoveCategoryFromItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :items, :category, :string
  end
end

