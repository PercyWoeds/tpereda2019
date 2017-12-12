class Notacredit < ActiveRecord::Base

validates_presence_of  :code,:subtotal,:tax,:total,:mod_factura,:nombre

validates_uniqueness_of :code, scope: :nota_id 
 
belongs_to :client
belongs_to :notum

    def get_nombre
      if self.nota_id = 1 
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
   
end
