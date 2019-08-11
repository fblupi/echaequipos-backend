class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.bigint  :match_id,        null: false
      t.bigint  :affiliation_id,  null: false
      t.boolean :attendance,      default: false

      t.timestamps
    end
    add_index :players, :match_id
    add_index :players, :affiliation_id
  end
end
