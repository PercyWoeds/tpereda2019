class AddMail3ToCLients < ActiveRecord::Migration
  def change
  	  add_column :clients, :mailclient3, :string
  end
end
