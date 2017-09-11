class AddMail2ToCLients < ActiveRecord::Migration
  def change
  	  add_column :clients, :mailclient2, :string
  end
end
