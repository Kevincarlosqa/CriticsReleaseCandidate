class CreatePlatforms < ActiveRecord::Migration[7.0]
  def change
    create_table :platforms do |t|
      t.string :name
      t.integer :category, default: 0

      t.timestamps
    end
    add_index :platforms, :name, unique: true
  end
end
