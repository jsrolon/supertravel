class AddEventsToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :events, :text

  end
end
