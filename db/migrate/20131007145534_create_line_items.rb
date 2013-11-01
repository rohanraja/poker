class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :player_id
      t.integer :round_id
      t.integer :level
      t.decimal :amount, :precision => 8, :scale => 2
      t.boolean :pass

      t.timestamps
    end
  end
end
