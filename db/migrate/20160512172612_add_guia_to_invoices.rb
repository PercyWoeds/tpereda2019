class AddGuiaToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :guia, :string
  end
end
