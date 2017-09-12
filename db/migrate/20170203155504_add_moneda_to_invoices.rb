class AddMonedaToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :moneda, :integer
  end
end
