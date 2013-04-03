class AddDefaultValueForVisitsCounter < ActiveRecord::Migration
  def up
    remove_column :urls, :visits
    add_column :urls, :visits, :integer, default: 0
  end

  def down
    remove_column :urls, :visits
    add_column :urls, :visits, :integer
  end
end
