class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string  :title, null: false
      t.decimal :price, null: false
      t.text    :description

      t.timestamps
    end
  end
end
