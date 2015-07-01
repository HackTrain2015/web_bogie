class CreateStations < ActiveRecord::Migration
  def change
  	create_table :stations do |t|
  		t.string :name
  		t.string :station_code
  	end
  end
end
