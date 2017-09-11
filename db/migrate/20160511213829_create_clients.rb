class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|

      t.string :vcodigo
      t.string :vruc
      t.string :vrazon2
      t.string :vdireccion
      t.string :vdistrito
      t.string :vprov
      t.string :vdep

      t.timestamps null: false
    end
  end
end
