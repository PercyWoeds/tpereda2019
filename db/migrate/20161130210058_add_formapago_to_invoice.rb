class AddFormapagoToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :formapago, :string
  end
end
