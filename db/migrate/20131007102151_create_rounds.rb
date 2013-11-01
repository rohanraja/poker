class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.decimal :pot, :precision => 8, :scale => 2, :default => 0
      t.decimal :big_blind, :precision => 8, :scale => 2
      t.decimal :small_blind, :precision => 8, :scale => 2
      t.decimal :call_value, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
