class AddDescripToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :descrip, :string
  end
end
