class AddCodplaca10ToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :codplaca10, :string
  end
end
