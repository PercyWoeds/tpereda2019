class CreateMailings < ActiveRecord::Migration
  def change
    create_table :mailings do |t|
      t.string :td
      t.string :serie
      t.string :numero
      t.string :ruc
      t.boolean :flag

      t.timestamps null: false
    end
  end
end
