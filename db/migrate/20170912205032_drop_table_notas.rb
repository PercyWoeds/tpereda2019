class DropTableNotas < ActiveRecord::Migration
  def change
    drop_table :nota 
  end
end
