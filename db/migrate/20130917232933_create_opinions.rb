class CreateOpinions < ActiveRecord::Migration
  def change
    create_table :opinions do |t|
      t.text :text
      t.references :event

      t.timestamps
    end
    add_index :opinions, :event_id
  end
end
