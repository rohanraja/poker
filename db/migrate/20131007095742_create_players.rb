class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.decimal :balance, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
