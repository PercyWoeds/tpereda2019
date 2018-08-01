class Notacredit < ActiveRecord::Base
  


validates_presence_of  :code,:mod_factura,:nombre,:quantity,:price 

validates_uniqueness_of :code, scope: :nota_id 
 
belongs_to :client
belongs_to :notum

    def get_nombre
      if self.nota_id == 1 
        return "CREDITO"
      else
        return "DEBITO "
      end 
    end   
      
    def self.import(file)
          CSV.foreach(file.path, headers: true) do |row|
          Notacredit.create! row.to_hash 
        end
      end    
      
    def self.to_csv(options = {})
      CSV.generate(options) do |csv|
    csv << column_names
    all.each do |product|
      csv << product.attributes.values_at(*column_names)
    end
   end 
   end 
 
   def update_total_items
      total = 0
      subtotal=0
      tax=0 
      b = Notacredit.find(self.id)
      subtotal = b.quantity * b.price 
      b.subtotal =subtotal.round(2)
      total = b.subtotal.round(2) * 1.18
      b.total = total.round(2)
      tax= b.total.round(2) - b.subtotal.round(2)
      b.tax = tax.round(2)
      
      b.save
   
    end


   
end
