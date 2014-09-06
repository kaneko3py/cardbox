class AddIsarchiveToCards < ActiveRecord::Migration
  def change
    add_column :cards, :is_archive, :boolean
  end
end
