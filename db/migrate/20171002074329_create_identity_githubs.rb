class CreateIdentityGithubs < ActiveRecord::Migration[5.1]
  def change
    create_table :identity_githubs do |t|
      t.references :identity
      t.string :token

      t.timestamps
    end
  end
end
