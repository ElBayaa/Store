class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :data_type
      t.string :key
      t.string :value

      t.timestamps
    end

    add_index :settings, :key, unique: true
  end
end
