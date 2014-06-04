class AddCommenterToOpinions < ActiveRecord::Migration
  def change
    add_column :opinions, :commenter, :integer

  end
end
