class AddLinkstructreToCards < ActiveRecord::Migration
  def change
    add_column :cards, :is_link, :boolean
    add_column :cards, :original, :integer
  end
end
