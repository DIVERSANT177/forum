class RemoveRateFromAnswers < ActiveRecord::Migration[7.2]
  def change
    remove_column :answers, :rate, :integer
  end
end
