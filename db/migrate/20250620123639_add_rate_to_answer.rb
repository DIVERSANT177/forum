class AddRateToAnswer < ActiveRecord::Migration[7.2]
  def change
    add_column :answers, :rate, :integer, default: 0
  end
end
