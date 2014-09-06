class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :user_id
      t.integer :no
      t.text :question
      t.text :answer
      t.text :comment

      t.timestamps
    end
  end
end
