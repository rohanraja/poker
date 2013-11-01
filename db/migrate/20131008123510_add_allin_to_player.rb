class AddAllinToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :allin, :decimal, :default => 0
  end
end
