class AddActivitiesToCards < ActiveRecord::Migration
  def change
    add_column :cards, :total_answers, :integer
    add_column :cards, :good_answers, :integer
    add_column :cards, :reliability, :string
  end
end
