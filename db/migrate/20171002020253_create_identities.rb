class CreateIdentities < ActiveRecord::Migration[5.1]
  def change
    create_table :identities do |t|
      t.references :user
      t.string :uid, null: false
      t.integer :provider, null: false
      t.string :nickname
      t.string :email
      t.string :image

      t.timestamps
    end
  end
end
