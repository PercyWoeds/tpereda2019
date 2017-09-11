class Addflag1ToMailing < ActiveRecord::Migration
  def change
  	add_column :mailings, :flag1, :string
  end
end
