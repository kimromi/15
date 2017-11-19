class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.references :team, foreign_key: true
      t.integer :order
      t.string :name, null: false, default: ""
      t.string :background_color
      t.boolean :deleted, null: false, default: false

      t.timestamps
    end
  end
end
