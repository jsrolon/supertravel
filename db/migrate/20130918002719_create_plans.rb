class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.references :user
      t.text :description
      t.string :name
      t.date :starts_on
      t.date :ends_on

      t.timestamps
    end
    add_index :plans, :user_id
  end
end
