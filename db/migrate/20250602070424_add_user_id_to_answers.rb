class AddUserIdToAnswers < ActiveRecord::Migration[7.2]
  def change
    add_reference :answers, :user, null: false, foreign_key: true
  end
end
