class CreateIdentityTwitters < ActiveRecord::Migration[5.1]
  def change
    create_table :identity_twitters do |t|
      t.references :identity
      t.string :token
      t.string :secret

      t.timestamps
    end
  end
end
