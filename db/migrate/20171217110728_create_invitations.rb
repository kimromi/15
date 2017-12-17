class CreateInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :invitations do |t|
      t.references :team, foreign_key: true
      t.string :token
      t.datetime :expired_at

      t.timestamps
    end
  end
end
