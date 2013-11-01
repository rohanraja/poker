class AddPassToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :pass, :boolean, :default => false
  end
end
