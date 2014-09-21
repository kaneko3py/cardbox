class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :card_id
      t.integer :good_answers
      t.integer :total_answers
      t.string :reliability

      t.timestamps
    end
  end
end
