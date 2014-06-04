class AddCityToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :city, :string

  end
end
