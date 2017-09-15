class Notacredit < ActiveRecord::Base

validates_presence_of  :code,:subtotal,:tax,:total,:mod_factura,:nombre
validates_uniqueness_of :code
 
belongs_to :client
belongs_to :notum

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
