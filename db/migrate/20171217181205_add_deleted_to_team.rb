class AddDeletedToTeam < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :deleted, :boolean, null: false, dafault: false, after: :name
  end
end
