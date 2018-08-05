class CreateAffiliations < ActiveRecord::Migration[5.2]
  def change
    create_table :affiliations do |t|
      t.bigint  :group_id,          null: false
      t.bigint  :user_id,           null: false
      t.integer :affiliation_type,  null: false

      t.timestamps
    end
    add_index :affiliations, :group_id
    add_index :affiliations, :user_id
  end
end
