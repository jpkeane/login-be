class CreateNews < ActiveRecord::Migration[5.0]
  def change
    create_table :news do |t|
      t.string :title, null: false
      t.date :date, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
