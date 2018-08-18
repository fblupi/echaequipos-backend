class CreatePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :positions do |t|
      t.string :name_en, null: false
      t.string :name_es, null: false
      t.string :abbr_en, null: false
      t.string :abbr_es, null: false

      t.timestamps
    end

    create_join_table :affiliations, :positions, &:timestamps
  end
end
