class AddTagToCards < ActiveRecord::Migration
  def change
    add_column :cards, :tag, :string
  end
end
