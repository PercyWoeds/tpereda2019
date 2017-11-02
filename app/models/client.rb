class Client < ActiveRecord::Base

   validates_presence_of :vcodigo,:vruc, :vrazon2, :vdireccion 
    validates_uniqueness_of :vruc

	has_many :invoices, :class_name=> 'Invoice',	:foreign_key => 'vcodigo' 
	
	
	attr_accessible :vcodigo, :vdep, :vdireccion, :vdistrito, :vprov, :vrazon2, :vruc, :mailclient, :mailclient2, :mailclient3

      def self.import(file)
          CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
          Client.create! row.to_hash 
        end
      end       
      

	   def self.search(search,page=1)      
        where(["vrazon2 ILIKE ?","%#{:search}%"]).order('vrazon2')
     end



end
