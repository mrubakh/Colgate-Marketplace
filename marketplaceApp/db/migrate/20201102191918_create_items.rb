class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2
      t.string :image
      t.text :description
      t.boolean :listed
      t.string :status
      t.boolean :deliverable
      t.references 'user' #association to seller

      t.timestamps
    end
  end
end
