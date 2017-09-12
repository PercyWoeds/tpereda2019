class CreateNotacredits < ActiveRecord::Migration
  def change
    create_table :notacredits do |t|
      t.datetime :fecha
      t.string :code
      t.integer :nota_id
      t.string :motivo
      t.float :subtotal
      t.float :tax
      t.float :total
      t.integer :moneda_id
      t.string :mod_factura
      t.integer :mod_tipo
      t.string :processed
      t.string :tipo
      t.string :description
      t.integer :customer_id
      t.float :quantity
      t.float  :price
      t.float  :price2
      t.integer  :client_id
      t.integer  :notum_id
      t.string  :nombre 

      t.timestamps null: false
    end
  end
end 
  
