class CreateRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :records do |t|
      t.references :user, foreign_key: true
      t.references :team, foreign_key: true
      t.references :task, foreign_key: true
      t.datetime :at

      t.timestamps
    end
  end
end
