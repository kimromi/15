class CreateIdentities < ActiveRecord::Migration[5.1]
  def change
    create_table :identities do |t|
      t.references :user
      t.string :uid
      t.string :provider

      t.timestamps
    end
  end
end
