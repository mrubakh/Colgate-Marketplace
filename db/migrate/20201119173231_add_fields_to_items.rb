class AddFieldsToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :category, :string
  end
end
