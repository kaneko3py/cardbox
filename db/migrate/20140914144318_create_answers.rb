class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :user_id
      t.integer :card_id
      t.text :answer
      t.integer :count
      t.float :rate

      t.timestamps
    end
  end
end
