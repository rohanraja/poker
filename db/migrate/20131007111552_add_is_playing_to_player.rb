class AddIsPlayingToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :is_playing, :boolean, :default => true
  end
end
