class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :name
      t.text :summary
      t.date :release_date
      t.integer :category, default: 0
      t.decimal :rating
      t.references :parent, foreign_key: { to_table: :games }

      t.timestamps
    end
    add_index :games, :name, unique: true
  end
end
