class CreateVoideds < ActiveRecord::Migration
  def change
    create_table :voideds do |t|
      t.string :numero
      t.string :serie
      t.string :factura
      t.date   :fecha
      t.text   :texto

      t.timestamps null: false
    end
  end
end
