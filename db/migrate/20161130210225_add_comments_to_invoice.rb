class AddCommentsToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :comments, :text
  end
end
