class AddLevelToRound < ActiveRecord::Migration
  def change
    add_column :rounds, :level, :integer, :default => 1
  end
end
