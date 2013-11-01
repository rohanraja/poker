class AddImageurlToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :imageurl, :string, :default => '/assets/def_icon.jpg'
  end
end
