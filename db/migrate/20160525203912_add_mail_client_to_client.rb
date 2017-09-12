class AddMailClientToClient < ActiveRecord::Migration
  def change
    add_column :clients, :mailclient, :string
  end
end
