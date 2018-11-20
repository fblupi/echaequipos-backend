class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.bigint    :group_id,        null: false
      t.bigint    :affiliation_id,  null: false
      t.string    :name,            null: false
      t.datetime  :date,            null: false
      t.integer   :duration,        null: false
      t.integer   :status,          null: false
      t.integer   :min_players,     null: false
      t.integer   :max_players,     null: false
      t.string    :location,        null: false
      t.float     :latitude
      t.float     :longitude

      t.timestamps
    end
    add_index :matches, :group_id
    add_index :matches, :affiliation_id
  end
end
