class RemoveArchiveflgToCards < ActiveRecord::Migration
  def change
    remove_column :cards, :archive_flg, :boolean
  end
end
