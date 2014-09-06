class AddArchiveflgToCards < ActiveRecord::Migration
  def change
    add_column :cards, :archive_flg, :boolean
  end
end
